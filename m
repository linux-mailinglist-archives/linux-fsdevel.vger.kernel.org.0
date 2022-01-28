Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B0549F5CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiA1I7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 03:59:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiA1I7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:59:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33B0DB81FAF;
        Fri, 28 Jan 2022 08:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB77C340E0;
        Fri, 28 Jan 2022 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360360;
        bh=4yoIqw9LowZS2I5hqAuu9FXS3iDVuLfMLkYxabIfN3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9O3Rw6Yi9ioAukX1sLBaj5znyUeQor8eTFi7o6GL2cFW6MW3hxhqWsYdgsC8PTSt
         CMEYdsrVzS+4LGHxIU0nVIx/JKQ61qH8YHJ7a984Y98o9VG+0pOH7FK9YemnRXJ/0s
         iC3nwD7w2xeZTszhKGsrEErR9nGbzuY/HGeKTS950N+8EuooBuU+PIiuIWdFneULnw
         z29XSKB19Do4wg/EgF0Ca9uWKQTRzI9AcD4oGuTjTnVWsJiHHqPyLgBcUc2dsQr2NO
         zTIUubnlDiv7gobh9x80n2m/pIEZtpkeahYEGg2RflVIvSr/yvQKWe0Um83W0MFRs4
         gEgozztsrO0HQ==
Date:   Fri, 28 Jan 2022 09:59:14 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] LSM: general protection fault in legacy_parse_param
Message-ID: <20220128085914.rxrz7qt3uk7fp67d@wittgenstein>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
 <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
 <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:51:44AM -0800, Casey Schaufler wrote:
> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> a security module may return an error code indicating that it does not
> recognize an input.  In this particular case Smack sees a mount option
> that it recognizes, and returns 0. A call to a BPF hook follows, which
> returns -ENOPARAM, which confuses the caller because Smack has processed
> its data.
> 
> The SELinux hook incorrectly returns 1 on success. There was a time
> when this was correct, however the current expectation is that it
> return 0 on success. This is repaired.
> 
> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

Looks good,
Acked-by: Christian Brauner <brauner@kernel.org>
