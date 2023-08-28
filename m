Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C078B2B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjH1OKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjH1OJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:09:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA47C7;
        Mon, 28 Aug 2023 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vj5uG1CCKuX3jGxRE00yIXM6NXAYana45tP3A2WWLvg=; b=RHFK7QjW1d3z/cgEF/gIaMJXjl
        q9gk6zavVhCUT0REIgAdFLETumEDgNX31n5tOyQhnvkU8WCYCD8qtF2F7JIh87WewvVfSWsquA0tC
        uFCleufO1TvGFTPx/jUCwUZCsP2bebu06ODAaAcQbc/4rWi94TPHmbsFH+LtrkjQOR7/lEdbXixYt
        M+vPsoWZkWHpXWQ+JLcpwQucb2qNJ9pjhKvPZ0mYEZcF0oUJ2H7KL/8UwzwLzq0l0eEfbqJ83KUSP
        CPkyyt5HHwtXnAdZV1aiX3SpHgdJybm9ZYCfldIarOg79krPJg7SYxA8gZf6WAnxuLyRJx9OH1QRp
        BgsumDSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qacvu-001Zez-2i;
        Mon, 28 Aug 2023 14:09:34 +0000
Date:   Mon, 28 Aug 2023 15:09:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Message-ID: <20230828140934.GY3390869@ZenIV>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
 <ZOyMZO2i3rKS/4tU@infradead.org>
 <20230828-alarm-entzug-923f1f8cc109@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-alarm-entzug-923f1f8cc109@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:30:42PM +0200, Christian Brauner wrote:
> On Mon, Aug 28, 2023 at 05:00:36AM -0700, Christoph Hellwig wrote:
> > On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> > > use helpers for calling f_op->{read,write}_iter() in read_write.c
> > > 
> > 
> > Why?  We really should just remove the completely pointless wrappers
> > instead.
> 
> Especially because it means you chase this helper to figure out what's
> actually going on. If there was more to it then it would make sense but
> not just as a pointless wrapper.

It's borderline easier to grep for, but not dramatically so.  call_mmap()
has a stronger argument in favour - there are several methods called
->mmap and telling one from another is hard without looking into context.

For ->{read,write}_iter() I'd prefer to get rid of the wrappers.
