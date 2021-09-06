Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F9401D4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhIFO6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbhIFO6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:58:00 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FDBC0613C1
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 07:56:56 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id g34so2284751vkd.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wm+1SxyPhgZ2xyPaqVHOlIIYUpLoXtqsuq+0VC3Sjc=;
        b=moj6OWG2vw6GntXNWeTQgm7Smvy1QpBa4fBHcAMupAuzUukRol/FdrWgU5z93l3NPQ
         6MKcKRVOHIc1gnlY06/SaTKFIeV+7N4mqBXunJXSVgBRCYLv1sIi2A1t7PSoceroEu42
         nlrzfwR/cKNVYtbEIrt0+iEauNFt1iHYtCXY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wm+1SxyPhgZ2xyPaqVHOlIIYUpLoXtqsuq+0VC3Sjc=;
        b=iwJo41qvv/iihAiWsFWBj4UKBiDy4jo94HX2DAiY1DSztK4IcMeVr2uBNu8yQexSiF
         vgiRrnidotOt1ClGShJAOn6mpTrahZYadwVZ00abV7LPOb9sUWfJcHlq4oxNUpsqOpAl
         oTDfbbb1tFPWV3rOoIFYOtvzuR109nnLP+H6WQCd9o9lSWEeacOOICT0jwyA2eLGPzP+
         CrsPm+9aPJEtdSoSqxZfyv5FYmjTjiK7M70h6t7G52EkfuwaNPT+/68xAYZ2puyhPDSu
         G2WEEkNPKkoHBb5jrPZKv54pMYNQYzvBnXhs6lKJjsfhdBCHC40qNDE4MUHixMQRIDT4
         MUyQ==
X-Gm-Message-State: AOAM531OIF86rCljSz7F+yDuf4d/RpJT5LYnwAr5nHH7XYKFKpx018ZU
        n4g/vFL2Nyen0ghGAsYEByGvEZexVDa9yNYRDGIsAA==
X-Google-Smtp-Source: ABdhPJzqc2z0O4HypL+N5TiFC1yajscDCqIXhB97hRi7jls6qKs/M/pVB7E0LSC2ATi0XpZDADaqMYws03dQ9iRqjxM=
X-Received: by 2002:a05:6122:1430:: with SMTP id o16mr5404231vkp.14.1630940215149;
 Mon, 06 Sep 2021 07:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
 <YTYoEDT+YOtCHXW0@work-vm>
In-Reply-To: <YTYoEDT+YOtCHXW0@work-vm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Sep 2021 16:56:44 +0200
Message-ID: <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Fields, Bruce" <bfields@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 16:39, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> IMHO the real problem here is that the user/trusted/system/security
> 'namespaces' are arbitrary hacks rather than a proper namespacing
> mechanism that allows you to create new (nested) namespaces and associate
> permissions with each one.

Indeed.

This is what Eric Biederman suggested at some point for supporting
trusted xattrs within a user namespace:

| For trusted xattrs I think it makes sense in principle.   The namespace
| would probably become something like "trusted<ns-root-uid>.".

Theory sounds simple enough.  Anyone interested in looking at the details?

Thanks,
Miklos
