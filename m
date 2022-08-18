Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA97598756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbiHRPWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245691AbiHRPWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:22:03 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD57539F;
        Thu, 18 Aug 2022 08:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660836089; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ANI7IPRR551PJTpRtyF/vzZcTFfEc84mHr+GpDLqExtKSLVOTV+sY42RwadRJxrSjig2PIz1/9oyCgz5rEwez47HmXxfvJtH//rJbf4yF7P3BdQVkuCPLC1GulheaMi2rb73QoeR2shRpq4ivJZ0JgeqGfB/TK9oK/u0Q0LECTk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1660836089; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VU/9NQq/tY4qE6lA3If/jM8YrDr0mazxoc1R8N5jJzM=; 
        b=Gm4TZbzpKIAdX5WgaCIyI3RaM2qsBnQa2OrbXs99nBA5w4Xz5BQpNk+zUQHXfJTdPL+WFIF4FJIPAU7pT3sGIab9e0OoJ2r4yC4XwQmAis2awbxmm8tXrMVdfTggiKgz5QezJz1dx1KzyfGv8xUeK1/BbjCtn4mKPvJdFQxK53M=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660836089;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=VU/9NQq/tY4qE6lA3If/jM8YrDr0mazxoc1R8N5jJzM=;
        b=RMmO85lSetrrrFF2xKPs/f6gejNaB5fSXzegfG46VK5pASIAXAWgJTmJl/TbEZyW
        SYieXMe1kcpvE9mG1rek2hKz/TFiAC6pHbIRMeyKfcilX6BPzCnBuP24yAMYhN8ROKY
        6duj9GjcU7N5BttFAwNM6og9uNbI0ScOme2elwzk=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1660836076966185.1731467950858; Thu, 18 Aug 2022 20:51:16 +0530 (IST)
Date:   Thu, 18 Aug 2022 20:51:16 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "david" <david@fromorbit.com>, "djwong" <djwong@kernel.org>,
        "fgheet255t" <fgheet255t@gmail.com>, "hch" <hch@infradead.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>,
        "riteshh" <riteshh@linux.ibm.com>,
        "syzbot+a8e049cd3abd342936b6" 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <182b18b5d92.7a2e2b1623166.1514589417142553905@siddh.me>
In-Reply-To: <Yv5RmsUvRh+RKpXH@casper.infradead.org>
References: <20220818110031.89467-1-code@siddh.me>
 <20220818111117.102681-1-code@siddh.me> <Yv5RmsUvRh+RKpXH@casper.infradead.org>
Subject: Re: [syzbot] WARNING in iomap_iter
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022 20:20:02 +0530  Matthew Wilcox  wrote:
> I don't think changing these from u64 to s64 is the right way to go.

Why do you think so? Is there somnething I overlooked?

I think it won't intorduce regression, since if something is working,
it will continue to work. If something does break, then they were
relying on overflows, which is anyways an incorrect way to go about.

Also, it seems even the 32-bit compatibility structure uses signed
types.

Thanks,
Siddh
