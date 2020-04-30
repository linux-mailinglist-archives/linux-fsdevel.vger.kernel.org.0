Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147DF1C08C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgD3VHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbgD3VHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:07:10 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95EC035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:07:08 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so951015oij.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y0BHfY++8ymwoFsyQG3f2a5F1M5FJigDreAt8/y9wkw=;
        b=tT/RHF/bfPnesXqFK6JRHF+/fL7TDEmxW2tMH4v+nGg1wDgnRcU5rKSFkUGLbHazAh
         sn9+u/EMiquXspfC2UFxr9W2jqoSZSaLda3L7b3hzX+oPSu0gd8P8x1QrH3VGLm02C2C
         +s4OMCohXuqTaeY0tssIradw6kYxEW9PsJwfBj4gPy1U66MYcQf7DncO6ljoe+lk5jvU
         fKnVvytwK6V0wNiaFIWTLhP7C2dzeakwoRCc3lSBWMr3v2MOLe2j3gf80/t/ARVNw99j
         on5eko7k+LRuZjwBgwTw7HxQuWXx22H4hy3vhQrNPmMiXk/Ns5dhIpdqZL0xyj8TkFQ6
         0vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y0BHfY++8ymwoFsyQG3f2a5F1M5FJigDreAt8/y9wkw=;
        b=CaKa+IfiEqTGZjkDM3fvefmlnzmeYsnDbia045fDwzcoDbLmMgx76s57Ta1UKnCAyv
         39sP4hfCMtX1CB+/flbw7ZGFIpXddjcBnQLnNdg2GHGvO/KndioJ3MoSoeLwkwpmX6hP
         4hkw7QmZJoieoWBcRHmEIO228pgt3n2jRPNUTZFrwWQ5JDJmhjbJylxfJ5XJzLsYk73Y
         On3XB8/qBrhlkWSwMhpvI4MNBsrO43k3MJB2GPpSs2P2HGuIp1WiDGmZIHv33w7Z+/Pq
         LrLbk98m6URHt78mdsivxHjRP1DOEUeA9oUYaKPWg66GvsTzTn6ilNKMWlIc5v3Hl/ww
         VrRA==
X-Gm-Message-State: AGi0PuYHJ49FPq60ZquYagPT2b+qoABjR5mkrqrRtTIGVKaa47IZXtCs
        oVEoYHdSjvfguN1mvEmu9EWSPA==
X-Google-Smtp-Source: APiQypIF07p8WMlOqZkR0BZmdYjCNv2JY6o4DDmIm1Lcv4/Fio2GvfUcSL2SHecf2CFgmirguuRxAg==
X-Received: by 2002:aca:438b:: with SMTP id q133mr799994oia.148.1588280828409;
        Thu, 30 Apr 2020 14:07:08 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id v9sm268330oib.56.2020.04.30.14.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 14:07:07 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Rich Felker <dalias@libc.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <20200430145123.GE21576@brightrain.aerifal.cx>
From:   Rob Landley <rob@landley.net>
Message-ID: <34688b36-4fdf-0c71-77cc-f98e6b9962df@landley.net>
Date:   Thu, 30 Apr 2020 16:13:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430145123.GE21576@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/20 9:51 AM, Rich Felker wrote:
> This sounds correct. My understanding of FLAT shared library support
> is that it's really bad and based on having preassigned slot indices
> for each library on the system, and a global array per-process to give
> to data base address for each library. Libraries are compiled to know
> their own slot numbers so that they just load from fixed_reg[slot_id]
> to get what's effectively their GOT pointer.
> 
> I'm not sure if anybody has actually used this in over a decade. Last
> time I looked the tooling appeared broken, but in this domain lots of
> users have forked private tooling that's not publicly available or at
> least not publicly indexed, so it's hard to say for sure.

Lots of people in this area are also still using 10 year old tools because it
breaks every time they upgrade.

Heck, nommu support for architectures musl doesn't support yet is _explicitly_
the main thing keeping uClibc alive:

  https://www.openwall.com/lists/musl/2015/05/30/1

Rob
