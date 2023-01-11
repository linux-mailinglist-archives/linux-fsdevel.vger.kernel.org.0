Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CC66628C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 19:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjAKSLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 13:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjAKSLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:11:36 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37336319;
        Wed, 11 Jan 2023 10:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673460649; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=XK334mSDM5kmOwB83c6m3XjQpBNidXCnQRa0Kt8LxfcLp9/P6LKxmi1yeR8kABg7cDRm7uXwI87q3kPp9xsCmkrP8cJXaVmzBGg78fwkKruXv3AdkQppr2Q5o9tGu/kdaeF1M0qhUViteMnqluk12JePT6hLgjF1oQNxOX2iVXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673460649; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6fcdNPybl+xUYpUP49ToyIcYZNVnjP3wgQCGB02TB14=; 
        b=GzhuBHGBTW2k6dsILLUtk0IpsEc0Thfwi3umO3FTt0O3rOl6RboYc0Jt3djtt6EJrY3vPAxvUcntVFkBh+2O3Nj3jPrUXgDIkgHajFFoz4V0nwaIQeyVgReh8v9ftile2ynZ/XGS1+wW0FcGsDdbjHLb9zBilrDk3pgZU6UMYYM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673460649;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=6fcdNPybl+xUYpUP49ToyIcYZNVnjP3wgQCGB02TB14=;
        b=XsVyyOmzz2c7qO+tfmyaDoAhPhPtr4o31hhMHfbjR9AT0O+k+G+opfb6sRRRvEQJ
        VtF1850edm1idJrb4evO5j8YkQwoaOdMF8bXWIqI5WwgaGssFndVnWL7yHYVZCm9DJ7
        uVD+8td/4ZS/VSG80WkbwrQsMvOvnOKTCBBSKfsQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1673460638656299.0457988820257; Wed, 11 Jan 2023 23:40:38 +0530 (IST)
Date:   Wed, 11 Jan 2023 23:40:38 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me>
In-Reply-To: <2433039.1673455048@warthog.procyon.org.uk>
References: <20230111161934.336743-1-code@siddh.me> <2433039.1673455048@warthog.procyon.org.uk>
Subject: Re: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use
 it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Jan 2023 22:07:28 +0530, David Howells wrote:
> Seems reasonable.  Have you run it with the keyutils testsuite?
> 
> David

I had not, but I did now.

I first ran all the keyctl tests with ./runtest.sh keyctl/**/*
All of them passsed. Log: https://pastebin.com/PBm6h5E2

All tests in tests/ pass except features/builtin_trusted, which
fails even without the patch. (Failure log: https://pastebin.com/SGgAbzXp)

Thanks,
Siddh
