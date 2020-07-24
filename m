Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2922CE47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXTDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXTDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:03:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A757C0619E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:03:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so5725483pfm.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sdXgEvqGYHlymvqSceJ6jkKcKZE63vnTThrEFoJfoJI=;
        b=U21XHuTNZcd9Xi31/xCf87Rkodq7UIatsvvV/UwKN/JzlFCu0PB6GXerCOvF6wBSK+
         SC2WOUDhPlu1q875fotSfx1rUNIyJCPwLsBy0JiUGot5W6Q50r/BPrfciAdVtp7Uwlle
         rtPo4Tole4s/1hOtfMBeGT54AFN8aogMq5g4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sdXgEvqGYHlymvqSceJ6jkKcKZE63vnTThrEFoJfoJI=;
        b=SYwDr+uYzavXeiUeqZip64Sb4B8/sF0J5G4zDY0envtVf97TTI1dbr3jlQiYY27HdI
         vmjEAJq6rjLnmXw9juc3SxCsUiSd7qG8/p/U9ptPl9+OryKwTLG5p8u8evxZvjhZg13A
         mOEmSVQPNxKG607eLKe0hW+/d/aCyA0ikCoqGz0EGo4L51qBssC4zDFWemxa/DxlW5Uv
         eWb4XgBWNlPM3oc/lg0za+l+QOt8Hll8KRYwiIUHyHvteAGHQabU8+Of4xdMa1i2db4t
         uQHaOdC6cZz6a0ZxFv95/pWqS3Ee9m7/wDfxJ9ourniw6BRWtYoaZhWcJFa6Q40XCJxE
         4CQw==
X-Gm-Message-State: AOAM531baLpBK6hjGEr2nLNia3Diw0MTW2Kuxwz+sRUD+jmxICoxMAUg
        NjxFGuGCdzhExz2YWUelVwaueA==
X-Google-Smtp-Source: ABdhPJxz4vuqoUWyBigx8RahhArmNJ84Nut7BOOCsUQANkvjswnwvqIw0Juf0zWwzmKl2+qs8JH6nQ==
X-Received: by 2002:a63:140f:: with SMTP id u15mr9259752pgl.94.1595617432993;
        Fri, 24 Jul 2020 12:03:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm7436424pfa.92.2020.07.24.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:03:52 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:03:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: Re: [PATCH v7 6/7] selftest/openat2: Add tests for O_MAYEXEC
 enforcing
Message-ID: <202007241203.E4A515733@keescook>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723171227.446711-7-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:12:26PM +0200, Mickaël Salaün wrote:
> Test propagation of noexec mount points or file executability through
> files open with or without O_MAYEXEC, thanks to the
> fs.open_mayexec_enforce sysctl.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
