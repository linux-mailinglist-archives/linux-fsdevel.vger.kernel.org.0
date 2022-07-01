Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFF563B68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiGAVAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiGAVAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:00:31 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1F6B25E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 14:00:29 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8AD9BC01F; Fri,  1 Jul 2022 23:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656709228; bh=LnIc0cWwjD9rQr7jX/eEQHXnJWjIDXq69sheh2Gzmno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y8WCx1PUqZ6FFCZo3zuwp/XIt1FBFvIkn8GBxkFt5b6IOX3TnWwDz8SFwNXmBVafM
         wlZtiIhP0npf9JdPUe9IlwVOLDMnxO4xP2EbSHmm4l6n43w4gbktvV8Q78N2A/1HH2
         w/VqBd14EjHr4QvHtAXCsvMNIOUM/20pNxw7We3gzzLb/cdfx6FAsHnoq/OiZdMSg1
         ROuP+yaHI+s9jwb3hYxHwygDC5DMXhn0N7DRLvkUz0YmMrI4Rd4KDCECZ34mVsWgkE
         WfKZXLQp1lyylfzRRypGtRV87O6s5nMe0hoBn7jMMDTTb3PmTh60p2M8BB7kYdAa9q
         w73YwRXulivhQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 29143C009;
        Fri,  1 Jul 2022 23:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656709227; bh=LnIc0cWwjD9rQr7jX/eEQHXnJWjIDXq69sheh2Gzmno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyGuxH4NmEQCtIcB1gTmYhgeEQNkmVk4czhiGlMKAo3dgweTYwK5+57sT1mUWqrvu
         ZGju5kzxMCP1vJGjkZhxJWYf6ug9I5YmX3bLKtFFmNywUc14+NIbtIS0xoLHFtVJ08
         pf5i9oJFLAQR0jQTSVuImvM/LSPWCQWXlxvUCzLowcJYDI3NJj6OJoPHb8BhMvNDCT
         VqVR1+xUM1nAHQMD/tP9/dBTDgb2IXJhnb2t3KG4NwQLi+msUgvglAgUl9MCYAbiyY
         00NM96q0fhkBtn3gvoGU6gNM3ajF2YqW1DjnP2m/CyiSVAKNjV/r2TWTLwRpmzOMM0
         +6AG3Tt/WSnsQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e6d40917;
        Fri, 1 Jul 2022 21:00:21 +0000 (UTC)
Date:   Sat, 2 Jul 2022 06:00:06 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 01/44] 9p: handling Rerror without copy_from_iter_full()
Message-ID: <Yr9gVtOKPiDR/IP6@codewreck.org>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <Yr6TbVQvu+noSzc8@codewreck.org>
 <6628265.VPEUYjqhpI@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6628265.VPEUYjqhpI@silver>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Schoenebeck wrote on Fri, Jul 01, 2022 at 06:02:31PM +0200:
> > I also tried 9p2000.u for principle and ... I have no idea if this works
> > but it didn't seem to blow up there at least.
> > The problem is that 9p2000.u just doesn't work well even without these
> > patches, so I still stand by what I said about 9p2000.u and virtio (zc
> > interface): we really can (and I think should) just say virtio doesn't
> > support 9p2000.u.
> > (and could then further simplify this)
> >
> > If you're curious, 9p2000.u hangs without your patch on at least two
> > different code paths (trying to read a huge buffer aborts sending a
> > reply because msize is too small instead of clamping it, that one has a
> > qemu warning message; but there are others ops like copyrange that just
> > fail silently and I didn't investigate)
> 
> Last time I tested 9p2000.u was with the "remove msize limit" (WIP) patches:
> https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> Where I did not observe any issue with 9p2000.u.
> 
> What msize are we talking about, or can you tell a way to reproduce?

I just ran fsstress on a
`mount -t 9p -o cache=none,trans=virtio,version=9p2000.u` mount on
v5.19-rc2:

fsstress -d /mnt/fstress -n 1000 -v

If that doesn't reproduce for you (and you care) I can turn some more
logs on, but from the look of it it could very well be msize related, I
just didn't check as I don't expect any real user

--
Dominique
