Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1852529DFE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbgJ2BHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbgJ2BGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:06:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34BC0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:06:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so1186170lfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bPMDf0qf5u7i+D1hct4Y8ywTPSNEiqZnANVXp2csHmo=;
        b=UDRPLu9msJZF3jU3f0cfRMmMUjv4al6mEdH+doXP3CJs1E+meQHwswUn6FfxeU4M7Y
         mdjF6dlxs/r9X+nsG+jvBBpuJoeemwz7oZzHEH8cu2FuE4WoJMkmPz/Ji0yhM4+WiFtB
         rhpBehRSmY/cTeZk76/aJgyzXOLL3NJE1/q4NlCTkpqRI97pcMZ+gNtjS3uoF4nuh7W1
         yw24PiXpzrFEiT3OI82ePRsw7PnnCJjT7Cw+g66nh4wZX1yx+HybJu5UCEhtHD658mi+
         886WmiZsQzGj6z4/CpD39D+FU4YLDTEf8HsVVyfPaptpyJrsYS5a5QKE4zded/CZpn7z
         MwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bPMDf0qf5u7i+D1hct4Y8ywTPSNEiqZnANVXp2csHmo=;
        b=TG90191eYlOWN3CIi26rCKXDClToSJNFIZpQimvTtRp2oFUdrEMpicyNAZy7Eq60iI
         5p9kwILgxv60o3FYn25uGOlbqLMhrxx2PPoanSyTum3HIVdh1ZhNBBOxbDqVaARIvBpx
         bUE/ll3JSQJF1NfrUdGVREhCHLTjqf4ClLWT/mLS0xKZ9bC+auOBrHnVRO3BZ2WhPDKN
         4ecsNgkzybvZ/Cm5ZfVE9x64bxGE+LzUbWkjTFinBTaCecmQmqb3seL+Nc/8peEkdIXs
         a+aBMurt70gCoYVS8kHcnm62J6Kazwboa0lzDyQY0PJ4zT6rZGS1PEhnPugrsgrNmmLY
         Pb+A==
X-Gm-Message-State: AOAM531c9LS1ezVMqQZxhtVknsR/jjwu8Rr24tn5YCx/MXPO9FJXeQVP
        6K/gt7CSZ7otrRHQVgBsYHOQgy5LrbRuqRdmhQ5zjA==
X-Google-Smtp-Source: ABdhPJzDdFVnRlhR1ZLyXcR/6gy+QFM2Be7EL54Ws7cTI4I+QtUU5EktO2FmKhpKLEYWon1ieCyZ/uOiqgKG+1NYZAk=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr584148lfr.198.1603933608096;
 Wed, 28 Oct 2020 18:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-7-mic@digikod.net>
In-Reply-To: <20201027200358.557003-7-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:06:21 +0100
Message-ID: <CAG48ez0venF9OnBG82yc8U+px1LUfUU498f1kJxYMu0hcU0+-A@mail.gmail.com>
Subject: Re: [PATCH v22 06/12] fs,security: Add sb_delete hook
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> The sb_delete security hook is called when shutting down a superblock,
> which may be useful to release kernel objects tied to the superblock's
> lifetime (e.g. inodes).
>
> This new hook is needed by Landlock to release (ephemerally) tagged
> struct inodes.  This comes from the unprivileged nature of Landlock
> described in the next commit.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>
