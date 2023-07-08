Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3274BA4A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 02:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGHAAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHAAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:00:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45366128;
        Fri,  7 Jul 2023 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vrELjCRWUuWgBxG/0NmdBEll0kHxCUngDsbAfQ8U4SM=; b=SospscAnESYLmVjxT53N4kth/D
        U3MJHJ42KyDTnes6JefBnFLdIjMF8Biw22nxOV/H74eeclvSZc4jYAYwI7iCXsYUWXZb8OtKIDr5z
        XJEhW0sqU4ASIMp3THBnDU90JrL7xL9MZRH25KW41GnlCgoqBy56jqh77+JDi/yZ1dbsaGk0JrYmk
        3vEEYDrl8+OczcI5ruvlLDBGcJZogg9cU5O886wYEg7FqEOVNPOVPepyJey/atA5cMjpWQcHbe6dj
        DZg/oxCut1sFJ+2PNdjrX2LUl89baewoxeEBYtimaNWIaL/o5n5xrNzWZYYHgUUgfkeKzeWScYk3H
        iSd3816Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHvNF-00CTIK-1p; Sat, 08 Jul 2023 00:00:29 +0000
Date:   Sat, 8 Jul 2023 01:00:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <ZKinHejv+xBq+gti@casper.infradead.org>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:56:45PM -0700, Linus Torvalds wrote:
> +static int busy_pipe_buf_confirm(struct pipe_inode_info *pipe,
> +				 struct pipe_buffer *buf)
> +{
> +	struct page *page = buf->page;
> +
> +	if (folio_wait_bit_interruptible(page_folio(page), PG_locked))
> +		return -EINTR;

Do we really want interruptible here rather than killable?  That is,
do we want SIGWINCH or SIGALRM to result in a short read?  I assume
it's OK to return a short read because userspace has explicitly asked
for O_NONBLOCK and can therefore be expected to actually check the
return value from read().

