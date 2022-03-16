Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BB4DB391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 15:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354114AbiCPOpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343521AbiCPOpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:45:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374737A12;
        Wed, 16 Mar 2022 07:44:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9010E1F397;
        Wed, 16 Mar 2022 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647441847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2dL7QjfQGBYPmqru5LS6JYrzRWQbyBgKOgOLVMI2Bg=;
        b=K0ecOdPQPhlaPJaMGWZiTyaSMpSNoPiwH/PIFy1sEX3ZD9+h51CLvoYjxDD0q/7BRrfQcC
        PVaMzURSzdXUy2QAzwOT+ZJ0iKJGc7w1P22+f3uKQFmkytpdixgiXh8ojFDREZxR//Gc6l
        zbhob7fo0xNfdZxJc/FwDxIbZM6oTVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647441847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2dL7QjfQGBYPmqru5LS6JYrzRWQbyBgKOgOLVMI2Bg=;
        b=FmzHmXOXSeuulpe8Acl/I4ZjNGXZZZCbdaTJ8gp1yHsEOfUFfPxMhjF3fcndznbbvmu+we
        zY8JucvExohYCzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E6A413322;
        Wed, 16 Mar 2022 14:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8qCmDbf3MWLkEgAAMHmgww
        (envelope-from <vkarasulli@suse.de>); Wed, 16 Mar 2022 14:44:07 +0000
Date:   Wed, 16 Mar 2022 15:44:05 +0100
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     David Disseldorp <ddiss@suse.de>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp
Subject: Re: [PATCH v3 1/2] exfat: add keep_last_dots mount option
Message-ID: <YjH3tcLbJTTxDwPY@vasant-suse>
References: <20220311114746.7643-1-vkarasulli@suse.de>
 <20220311114746.7643-2-vkarasulli@suse.de>
 <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
 <YjGr3IpZ4p55YuAB@vasant-suse>
 <20220316145728.709d85e0@suse.de>
 <CAKYAXd-EhGuywjtH8T4aFRJ6sP4nGvS=5O2u+EULLV+8s=0T4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-EhGuywjtH8T4aFRJ6sP4nGvS=5O2u+EULLV+8s=0T4A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi 16-03-22 23:08:32, Namjae Jeon wrote:
> 2022-03-16 22:57 GMT+09:00, David Disseldorp <ddiss@suse.de>:
> > On Wed, 16 Mar 2022 10:20:28 +0100, Vasant Karasulli wrote:
> >
> >> On So 13-03-22 09:01:32, Namjae Jeon wrote:
> >> > 2022-03-11 20:47 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:
> >> > > The "keep_last_dots" mount option will, in a
> >> > > subsequent commit, control whether or not trailing periods '.' are
> >> > > stripped
> >> > > from path components during file lookup or file creation.
> >> > I don't know why the 1/2 patch should be split from the 2/2 patch.
> >> > Wouldn't it be better to combine them? Otherwise it looks good to me.
> >>
> >> I just followed the same patch structure as was in the initial version
> >> of the patch.
> >
> > I'm fine with having both patches squashed together. @Namjae: should we
> > resubmit as a single patch or can you do the squash on your side before
> > submitting to Linus?
> I would be grateful if you resubmit it to the list after making it one:)
>

Ok, I will resubmit as a single patch in the new version of the patch.


Thanks,
Vasant Karasulli
Kernel generalist
www.suse.com<http://www.suse.com>
[https://www.suse.com/assets/img/social-platforms-suse-logo.png]<http://www.suse.com/>
SUSE - Open Source Solutions for Enterprise Servers & Cloud<http://www.suse.com/>
Modernize your infrastructure with SUSE Linux Enterprise servers, cloud technology for IaaS, and SUSE's software-defined storage.
www.suse.com

