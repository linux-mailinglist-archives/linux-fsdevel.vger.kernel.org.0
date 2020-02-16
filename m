Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475FD1604A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBPP5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 10:57:51 -0500
Received: from albireo.enyo.de ([37.24.231.21]:41872 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgBPP5v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:57:51 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1j3MID-0006zV-7T; Sun, 16 Feb 2020 15:57:13 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1j3MGr-0001RD-Ge; Sun, 16 Feb 2020 16:55:49 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
Date:   Sun, 16 Feb 2020 16:55:49 +0100
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Fri, 14 Feb 2020 19:35:26 +0100")
Message-ID: <87pneesf0a.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

> With fsid mappings we can solve this by writing an id mapping of 0
> 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> access the kernel will now lookup the mapping for 300000 in the fsid
> mapping tables of the user namespace. And since such a mapping exists,
> the corresponding files will have correct ownership.

I'm worried that this is a bit of a management nightmare because the
data about the mapping does not live within the file system (it's
externally determined, static, but crucial to the interpretation of
file system content).  I expect that many organizations have
centralized allocation of user IDs, but centralized allocation of the
static mapping does not appear feasible.

Have you considered a more complex design, where untranslated nested
user IDs are store in a file attribute (or something like that)?  This
way, any existing user ID infrastructure can be carried over largely
unchanged.
