Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76645161C93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 22:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBQVGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 16:06:15 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38056 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728142AbgBQVGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:06:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 466BB8EE218;
        Mon, 17 Feb 2020 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581973574;
        bh=Ye6mKiav8eWebLVBGMgayVZBb7heIIMuGJ8hEE7lDI0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iiSqW4Qs0du1znFCIxrbW3rsNBS0ZWGcsPJFuwAjeU8QZorEjP1m+ojE9K8y3RF85
         jE1YlPMzH3mVOpgj/RNhWtMpJ2DZ0xVfVh8WD3gKtkJSJF1EN5niLEOj//hhB5R2tV
         UN4LLK5FRcuYjJAQzcyvPzMwGiEm/zdL4PoB1A/Y=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V6nM5tdySi7P; Mon, 17 Feb 2020 13:06:12 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5BF0B8EE0F5;
        Mon, 17 Feb 2020 13:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581973572;
        bh=Ye6mKiav8eWebLVBGMgayVZBb7heIIMuGJ8hEE7lDI0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vP32wPjTKMUEEnhAJdE2mjE2viHl89h4Vo3gO8TCgoE5Vw7ZDz1Yhh5W6zKh1wE63
         zhP7dER+FAH3nmwMJ3XIXTIKcs0Hjm0ANG0DzAf558gdi8n39NF3ZwN/YHfUp4GOXu
         /ExioklqE0lmR12tgLheR4VDDmrNWdyveifOSCZI=
Message-ID: <1581973568.24289.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?ISO-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Mon, 17 Feb 2020 13:06:08 -0800
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-14 at 19:35 +0100, Christian Brauner wrote:
[...]
> People not as familiar with user namespaces might not be aware that
> fsid mappings already exist. Right now, fsid mappings are always
> identical to id mappings. Specifically, the kernel will lookup fsuids
> in the uid mappings and fsgids in the gid mappings of the relevant
> user namespace.

This isn't actually entirely true: today we have the superblock user
namespace, which can be used for fsid remapping on filesystems that
support it (currently f2fs and fuse).  Since this is a single shift,
how is it going to play with s_user_ns?  Do you have to understand the
superblock mapping to use this shift, or are we simply using this to
replace s_user_ns?

James

