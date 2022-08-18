Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E08597A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiHRAMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiHRAMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:12:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E687A3472;
        Wed, 17 Aug 2022 17:12:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kb8so385254ejc.4;
        Wed, 17 Aug 2022 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7/4BkSK2ivlMN+yfgyzhpWGDTfbhKFUZmzTnrYzYM9k=;
        b=F2cw+C/YT9FxyzpQFbxjpfEIH9bNn1dtT574gfnjGdftoV5vou9A5W090Ut3hLGOGz
         5690o5bQTfz5fbXSyvGmS3iHfNB+FcBSkykWT/KUMgzG/k66tBKzIu2OwrCMa7uRpv3H
         ah/rxnR4TyA2V3OqrHq0IL9iRt6yevG38bOz2Jxkre12nodacSEjVAxe/LgstE7f36mM
         /GAJ5c3xKBrtHSE3ugBqaqRAyqa//aI91KW3Bl+khkLUzpN0QoRc3t2LimNOJ0Ajr19B
         tH9sj/Oyk5nsT+yPBBhLTBatK4z58Gb09pK7mlzR5iDXtllDAwTMi4EY2XwhwhQJiSNs
         zyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7/4BkSK2ivlMN+yfgyzhpWGDTfbhKFUZmzTnrYzYM9k=;
        b=EnfwmnEPz03yMQJ/db877pfc2J3t55RkTmjZhP6XQg/gueh/Dad6RNs5kXN+xt39/f
         BessE+iXKs75C1qI1W5q7p1dvhq66/FlnYg6WJFBhlI8s+aNXYOJEsgGLuvMyprxCgn5
         /Jr++DVhqSEZ1TWAUMVb6ReKdgf09wUc13Nt/Wb2JZy0HnYyZr6IXHhLCdRilBew7WUR
         H58f8AWIfWOyX4WIhm+u7dKOkItnZWWDW28+GFtTn6KtFFZ7t85Hm1RMSF/lKuQoBCqd
         VM6s6K3Sx3EIYM+0v5We2iylpUMsgmBDc7zLrk5izkUB3jPvDAThVWlhKwpl147XPQpW
         wyrw==
X-Gm-Message-State: ACgBeo2n2+Jj2IcHrLcDmhT/mi//ykITAP7IvuPrl+BSJN3oK4ziMFOq
        Fceorj8wx1MMOpAiyGLNMYvOlihPHAtJVbdkRlU=
X-Google-Smtp-Source: AA6agR532kA+p5kNF2ebq2kRlZaERgnt87755to9TXMMNfH15pmv7Z9Uw4g7e5z/M3c5z7xZzRO9DC3rtAzBGUxNTUE=
X-Received: by 2002:a17:907:1c93:b0:730:c9c3:f6f8 with SMTP id
 nb19-20020a1709071c9300b00730c9c3f6f8mr296657ejc.17.1660781558495; Wed, 17
 Aug 2022 17:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV> <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
In-Reply-To: <Yv2BVKuzZdMDY2Td@ZenIV>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Aug 2022 20:12:27 -0400
Message-ID: <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 8:01 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 17, 2022 at 06:32:15PM -0400, Olga Kornievskaia wrote:
> > On Wed, Aug 17, 2022 at 6:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >         My apologies for having missed that back when the SSC
> > > patchset had been done (and missing the problems after it got
> > > merged, actually).
> > >
> > > 1) if this
> > >         r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
> > > in __nfs42_ssc_open() yields a directory inode, we are screwed
> > > as soon as it's passed to alloc_file_pseudo() - a *lot* of places
> > > in dcache handling would break if we do that.  It's not too
> > > nice for a regular file from non-cooperating filesystem, but for
> > > directory ones it's deadly.
> >
> > This inode is created to make an appearance of an opened file to do
> > (an NFS) read, it's never a directory.
>
> Er...  Where does the fhandle come from?  From my reading it's a client-sent
> data; I don't know what trust model do you assume, but the price of
> getting multiple dentries over the same directory inode is high.
> Bogus or compromised client should not be able to cause severe corruption
> of kernel data structures...

This is an NFS spec specified operation. The (source file's)
filehandle comes from the COPY operation compound that the destination
server gets and then uses -- creates an inode from using the code you
are looking at now -- to access from the source server. Security is
all described in the spec. The uniqueness of the filehandle is
provided by the source server that created it.
