Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1415B7DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 02:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiINANh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiINANg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:13:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB996582B
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePRJD+GRCIjzNdVBvudiZW56zYALjFnf5D8t0H57VjE=; b=QQmMn7fnN4xkpv55pdGCHEJWaR
        yyssQsEfanRnt6u0FcrPb/ApNUJ7gXIDtgnLYZS7vCp73BpQ+WxqodZJgPAm2CAv5fNU+ZAEjqp1m
        Zvr//zuiiWBAxWqeIRpqKBn8tvun90bSPVZMN5f1mievBW9z9ipvMNIJmu3Rk6tIz0IBe1ejU2V1x
        K/9bKzm1eXQu+eweA1/fNzR8sk3dr36OVU07xTbnE5Cm8jUrvrnZiQimAluSBV2wVLdEFpy7wJx2s
        L41qmUDlWLjaSqMaXlVET45gRgLUjsBUFvobrZAdbvrQ7hSK25ltQiIBODSs4NAIGdoqgPZWwd7WX
        c+nYzaDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYG1z-00G0EY-1s;
        Wed, 14 Sep 2022 00:13:31 +0000
Date:   Wed, 14 Sep 2022 01:13:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <YyEcqxthoso9SGI2@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV>
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166311315747.20483.5039023553379547679@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 09:52:37AM +1000, NeilBrown wrote:
>  - lookup the parents of both paths.
>  - lock the "to" directory.
>  - if the "from" directory is the same, or if a trylock of the from
>    directory succeeds, then we have the locks and can perform the
>    last component lookup and perform the link without racing with
>    rename. 
>  - if the trylock fails, we drop the lock on "to" and use lock_rename().
>    We drop the s_vfs_rename_mutex immediately after lock_rename()
>    so after the vfs_link() we just unlock both parent directories.

Umm...  Care to put together an update of deadlock avoidance proof?
The one in D/f/directory-locking.rst, that is.  I'm not saying it's
not a usable approach - it might very well work...

BTW, one testcase worth profiling would be something like
for i in `seq 100`; do
	cp -al linux.git linux.git-$i &
done
