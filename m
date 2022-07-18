Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31C5784A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiGROAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiGROAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:00:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72A13E8F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:00:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so10041825ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHY2XFlgl2NLjxbp3IJX7mROoJJbsUPeNGPlKQ+EoB8=;
        b=URoAobdrqE/O8AQ7j4HaQAkQQifIDJOjHQEZikevG3S/9TQGyczN03snGrh1alorqr
         6M4vw6fJ1a33T+kCcUv6T0LNlB1pOhJYqupiE2YjCA26ltCSbJSyvAa8bjKYvpRWloXD
         U4cJ3fQdpeZQu9Qu5L/Eo1heY6S/oII7wUQdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHY2XFlgl2NLjxbp3IJX7mROoJJbsUPeNGPlKQ+EoB8=;
        b=JtfsJZJVdekbA0vns3D+IQfPIcr3xmJN4/UUDrVE2xkpo8Zwlq0B00aHGvGbpF9qHR
         VJcs7iSR+dQMc3oD7I11KgCu+/izRv2LcS4efJqItJjMNmRpvkriLvNVlwqpfwB1zTQT
         FOweVKE93kmN6jlBSmTFe1TKmxu0m0Mo/qB8D1TDttbvfoWWcoYcNuezdwv6dE3Q3KZ1
         W0zxjqQvSOLi7sNhwx1ZHtfPTgiGroPc/voTU4a0sOyljFqHRZilIW0OcAeeJ4OpyHQ0
         DC/5fdg223d81vck/eET/5QAcjL1HnrlrFBp1yQIi8HJULvU8KYXtvdMRsF8YQzr+iL7
         uHqw==
X-Gm-Message-State: AJIora/nvpTmnY4IC8UV+O3xtIZ3u5TcjERrQ3fyWIDfXFqOrlDcNM/w
        09m73IQujIpSZKedovh6q/qigpLSIaDqfuNcI/tKXprejyF49Q==
X-Google-Smtp-Source: AGRyM1uDynW3UrN76V8amdi8R9LH9/Qltv/woG+eYPEQp1I/0SVr4WJulRvi+lG4AXMcehtj6HCawMNYr9oK2RzKo8I=
X-Received: by 2002:a17:907:270b:b0:72b:1418:f3dc with SMTP id
 w11-20020a170907270b00b0072b1418f3dcmr25695765ejk.748.1658152830461; Mon, 18
 Jul 2022 07:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220711174808.2579654-1-davemarchevsky@fb.com>
In-Reply-To: <20220711174808.2579654-1-davemarchevsky@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 16:00:19 +0200
Message-ID: <CAJfpegugHvgs0vZud6pYryVdJH2=uT6_gdka9YMnDF983rRgDg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] fuse: Add module param for CAP_SYS_ADMIN access
 bypassing allow_other
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Jul 2022 at 19:48, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
> superblock's namespace or a descendant"), access to allow_other FUSE
> filesystems has been limited to users in the mounting user namespace or
> descendants. This prevents a process that is privileged in its userns -
> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
> that is accessible to processes in parent namespaces.
>
> While this restriction makes sense overall it breaks a legitimate
> usecase: I have a tracing daemon which needs to peek into
> process' open files in order to symbolicate - similar to 'perf'. The
> daemon is a privileged process in the root userns, but is unable to peek
> into FUSE filesystems mounted by processes in child namespaces.
>
> This patch adds a module param, allow_sys_admin_access, to act as an
> escape hatch for this descendant userns logic and for the allow_other
> mount option in general. Setting allow_sys_admin_access allows
> processes with CAP_SYS_ADMIN in the initial userns to access FUSE
> filesystems irrespective of the mounting userns or whether allow_other
> was set. A sysadmin setting this param must trust FUSEs on the host to
> not DoS processes as described in 73f03c2b4b52.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Applied, thanks.

Miklos
