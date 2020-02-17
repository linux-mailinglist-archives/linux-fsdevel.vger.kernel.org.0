Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703CB161CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgBQVMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 16:12:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38212 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729894AbgBQVMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:12:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0BE148EE218;
        Mon, 17 Feb 2020 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581973921;
        bh=BdRwi/Nzv9AznkpvcnTjgxhKNwqBEU0S70n8Wu0Bn5o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rpMIBJotds+Yo2lcd6sA6SVAK8+n8pvt8gUu2VOCnDprrfkDCmN1qmP9QhLOJy/P2
         SbnmCAOvXAFu6acewv4Gr08MZZImD5W027mzXjWFKohSQh3DkX3vMqQc7Wmu920tLL
         IHTATALNMOtnmye6HnsPEnMIB6EnPoOwz1x4grxk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c1B0OvHGEPYW; Mon, 17 Feb 2020 13:12:00 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2241D8EE0F5;
        Mon, 17 Feb 2020 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581973920;
        bh=BdRwi/Nzv9AznkpvcnTjgxhKNwqBEU0S70n8Wu0Bn5o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r52INDU5B5zAM9KKlf6iT5w3ZKUdz39ndEjCu5aD6Kmy/VONBFJODeVfim+oNSVug
         Bgby3AfUWrX/XDySf7qNnqjQENFTCyvENPA2FfxmMrT+1vA0kerZ23RVfwQ4/v1sp4
         ZvEjyzG6S9kI6XKBBuKmliHapmDHRtcAdhXB5Y7w=
Message-ID: <1581973919.24289.12.camel@HansenPartnership.com>
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
Date:   Mon, 17 Feb 2020 13:11:59 -0800
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
> With this patch series we simply introduce the ability to create fsid
> mappings that are different from the id mappings of a user namespace.
> The whole feature set is placed under a config option that defaults
> to false.
> 
> In the usual case of running an unprivileged container we will have
> setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
> correspond to this id mapping, i.e. all files which we want to appear
> as 0:0 inside the user namespace will be chowned to 100000:100000 on
> the host. This works, because whenever the kernel needs to do a
> filesystem access it will lookup the corresponding uid and gid in the
> idmapping tables of the container.
> Now think about the case where we want to have an id mapping of 0
> 100000 100000 but an on-disk mapping of 0 300000 100000 which is
> needed to e.g. share a single on-disk mapping with multiple
> containers that all have different id mappings.
> This will be problematic. Whenever a filesystem access is requested,
> the kernel will now try to lookup a mapping for 300000 in the id
> mapping tables of the user namespace but since there is none the
> files will appear to be owned by the overflow id, i.e. usually
> 65534:65534 or nobody:nogroup.
> 
> With fsid mappings we can solve this by writing an id mapping of 0
> 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> access the kernel will now lookup the mapping for 300000 in the fsid
> mapping tables of the user namespace. And since such a mapping
> exists, the corresponding files will have correct ownership.

How do we parametrise this new fsid shift for the unprivileged use
case?  For newuidmap/newgidmap, it's easy because each user gets a
dedicated range and everything "just works (tm)".  However, for the
fsid mapping, assuming some newfsuid/newfsgid tool to help, that tool
has to know not only your allocated uid/gid chunk, but also the offset
map of the image.  The former is easy, but the latter is going to vary
by the actual image ... well unless we standardise some accepted shift
for images and it simply becomes a known static offset.

James

