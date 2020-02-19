Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACC1643DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 13:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSMGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 07:06:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgBSMGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:06:24 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4O7B-0002If-8k; Wed, 19 Feb 2020 12:06:05 +0000
Date:   Wed, 19 Feb 2020 13:06:04 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 09/25] fs: add is_userns_visible() helper
Message-ID: <20200219120604.vqudwaeppebvisco@wittgenstein>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-10-christian.brauner@ubuntu.com>
 <20200219024233.GA19334@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219024233.GA19334@mail.hallyn.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:42:33PM -0600, Serge Hallyn wrote:
> On Tue, Feb 18, 2020 at 03:33:55PM +0100, Christian Brauner wrote:
> > Introduce a helper which makes it possible to detect fileystems whose
> > superblock is visible in multiple user namespace. This currently only
> > means proc and sys. Such filesystems usually have special semantics so their
> > behavior will not be changed with the introduction of fsid mappings.
> 
> Hi,
> 
> I'm afraid I've got a bit of a hangup about the terminology here.  I
> *think* what you mean is that SB_I_USERNS_VISIBLE is an fs whose uids are
> always translated per the id mappings, not fsid mappings.  But when I see

Correct!

> the name it seems to imply that !SB_I_USERNS_VISIBLE filesystems can't
> be seen by other namespaces at all.
> 
> Am I right in my first interpretation?  If so, can we talk about the
> naming?

Yep, your first interpretation is right. What about: wants_idmaps()
