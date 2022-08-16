Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D45952D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiHPGpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiHPGpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:45:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F489CF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 20:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N77ngtWRSRHt5mfFDa6NjIOMszeuipLz9KcMhUOe91Q=; b=PRHKXAd0cD2AF0XiHPQneNH+6l
        XaR3oFGaSSIR7Ffcvj1ol39YP4s+0dx2dmppBvgPikCObkBXEB4QlJXxdUUIYgssCEdgKz4rZ5h0C
        0H1/renKUX17TxUhqIEhu1yO73LS8ruXmxeKYW+QKnXoyYfKNTLB9eHiC2+zhdL0sUQMOBOsOWKG6
        HHZuAQ2Ny/5gjlKOUxAbhcDN32ojfiaMOh8ErBn/9p7sYVas9YSbcVkUwcda9/Dp5RgSe6M9quWtW
        tJOZM9yhNE0/krJyZ03CjWwu8FmE209gNblJr1KhRtaO+FkbzwWttCirZTNSOz9DaH8L6meTJoq5C
        91C1gsfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNn5v-004uL3-JW;
        Tue, 16 Aug 2022 03:18:19 +0000
Date:   Tue, 16 Aug 2022 04:18:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] locks: fix TOCTOU race when granting write lease
Message-ID: <YvsMe33iUtXCKT8L@ZenIV>
References: <20220814152322.569296-1-amir73il@gmail.com>
 <Yvk3hPpCsX4H2/MR@ZenIV>
 <CAOQ4uxgWNQEznKQwyJOkY5pRmyOZqf-07kwBFa4O5kL98kAYkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgWNQEznKQwyJOkY5pRmyOZqf-07kwBFa4O5kL98kAYkA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:18:21AM +0300, Amir Goldstein wrote:
> > > +static inline void put_file_access(struct file *file)
> > > +{
> > > +     if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
> > > +             i_readcount_dec(file->f_inode);
> > > +     } else if (file->f_mode & FMODE_WRITER) {
> > > +             put_write_access(file->f_inode);
> > > +             __mnt_drop_write(file->f_path.mnt);
> > > +     }
> > > +}
> >
> > What's the point of having it in linux/fs.h instead of internal.h?
> 
> No reason. Overlooked.
> Do you need me to re-send or will you move it to internal.h yourself?

Resend, please...
