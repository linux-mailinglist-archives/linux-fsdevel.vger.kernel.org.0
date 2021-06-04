Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2239BBBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFDP0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFDP0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:26:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95519C061766
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jun 2021 08:23:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n12so7665843lft.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jun 2021 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ij2m//i2vBsvWVnhGZ0XX68OI3bOnqi+sqV2qYh6ilE=;
        b=0a0ckhenY104NwViOzux/nsF7MNxKyTmqDt4G3pYeg6N05gBAHLJ1e167QtHn+tanr
         l8jqrm/IaCj4GSXMxQ7nHM6w0q/WNVAK8h4GtYe7z8y2idNAJ6tXLaOFhy/DulQj2QRp
         DC2B8mE+JPu3LcDhNvivHczs3p0QQc3uTbyom6kOciHY5sRoMwEdQabF5td7wcD9qonk
         Xj5j+SAtQaGJsFdIzhQWJuD4sPLe0Fh8ecxyF70FaMeIkknYs4EkZr8M6uaUrwZ/UbIW
         pVwjp69OKq4ls0OmKT4wBQzA3BoUyebi02nVubEAtu2tBtr7NWntpSkAdXhkBDt62mVS
         WO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ij2m//i2vBsvWVnhGZ0XX68OI3bOnqi+sqV2qYh6ilE=;
        b=hFjGLItnJe4qexQ+hZ8NY2BD1JsCdi0EQEUgeMg9PGqeXyMD1b3Td5uAUIZ4NTR0mz
         KbUfU0Rm/Q0dalntFRSpRHVDiuoX0PaOhnPY4K8iVHZQ8+CC30didwwh1KUj3k/dMcAb
         YFXqzU4rhpY60h+YnCJpp9GpqkA1Ro2KRZtCllwEo1JwT1E8v4nD/ySmCW7TMJEcPCER
         R3V/2OsMJ/WkbtmczWWsMqP9yNPiP48UoDeNY9zDiOQYWsdCZC74k1mtwQDc+ZroZaHF
         pHo6niJvJGq46nhByUft6DvU2j272L3yQJyDobIc+llPK/YXn5ZmeM/zhXalXH7+8tim
         nE2g==
X-Gm-Message-State: AOAM531gOYyK/1WronxPnXnqDOaKQl9PsnumHEzMYtd2rvag7uLn4GTR
        qQKZP/aBPYnM/+iLQCna/HRPInXbvclB1A==
X-Google-Smtp-Source: ABdhPJy+REWo212Wm8EnBabZxH14h5sBHwmDpzuQ7H2pjbEiesqoXy6o5AY9mSz57y/2j7sa5NNzFg==
X-Received: by 2002:ac2:4899:: with SMTP id x25mr2636953lfc.372.1622820236389;
        Fri, 04 Jun 2021 08:23:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l15sm496245ljc.35.2021.06.04.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:23:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D566B1027A9; Fri,  4 Jun 2021 18:24:07 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:24:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ming Lin <mlin@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: adds NOSIGBUS extension to mmap()
Message-ID: <20210604152407.ouchyfuxjvchfroe@box>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
 <1622792602-40459-3-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622792602-40459-3-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:43:22AM -0700, Ming Lin wrote:
> Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
> "don't SIGBUS on fault". Right now, this flag is only allowed
> for private mapping.

That's not what your use case asks for.

SIGBUS can be generated for a number of reasons, not only on fault beyond
end-of-file. vmf_error() would convert any errno, except ENOMEM to
VM_FAULT_SIGBUS.

Do you want to ignore -EIO or -ENOSPC? I don't think so.

> For MAP_NOSIGBUS mapping, map in the zero page on read fault
> or fill a freshly allocated page with zeroes on write fault.

I don't like the resulting semantics: if you had a read fault beyond EOF
and got zero page, you will still see zero page even if the file grows.
Yes, it's allowed by POSIX for MAP_PRIVATE to get out-of-sync with the
file, but it's not what users used to.

It might be enough for the use case, but I would rather avoid one-user
features.

-- 
 Kirill A. Shutemov
