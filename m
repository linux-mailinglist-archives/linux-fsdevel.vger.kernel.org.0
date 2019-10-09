Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E10D1732
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 19:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfJIR5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 13:57:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39047 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIR5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:57:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so3416730ljj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8boM57nsIRzYbBpN0Z2Y51IdQe2gX/7UPNvVMmUq/U=;
        b=h0bAzS/dV9bQ6OnmXiwCK9ZIyyBp1EgxxpfnZdS3eiJkJ4Cjz7v9qeZ5N91ha6cYYN
         sdAGRVz3vOBIiPXxDatCim0mPu9JCDWAHWzCx9srQuMd9i2Of+bFJ7pwT0s3HSW9A+uI
         g3PA1uiN+F7kYnzzhfntyPIl5pCuME5B6pPLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8boM57nsIRzYbBpN0Z2Y51IdQe2gX/7UPNvVMmUq/U=;
        b=jWozWD8JMqYqDLTnTs9ZaWef/5eQjkGyWRC5kcT2usDRIrskTkZrTsDGZBFzPjFlkm
         Ks0ZjGW0pj1A7V/nARQPuhfcOS0cFAlbXceVWxTgXDxCpG+KOCpJ436LY/LjhYTTEnwm
         Nz71F6TrHYYwPPp/P+D/HlyzBA1PL2fhxGCDVozaKzxAaLDAF90VPoEmLK7UBLp/bddS
         ydmbE2gr+nyXicDYwOUhQoD+xAKnyIlQgPSNcoOd+LPdm3ynB3lsomBi6h7LVU/NiDXT
         TVDhb7RKcoHBsxBqG9sCx1s26/BKmiH1HvaUYXEelbfMo6VpOfCx+CYymaO5tZNLmsr0
         yKrA==
X-Gm-Message-State: APjAAAV7aIa+aHdC6nhB24O2+stnbCWKFDIJj3xE8p9BAxyYS5R0GKot
        3WcT80fzUnJyah6/yUTi7eCrEB0c50I=
X-Google-Smtp-Source: APXvYqyoajdIABNaVw+GmIF9j25HkGEiaP6r1Alt63tBJURPjIqi+xxB2gWPUcKVb2PnsGOg6xsxcQ==
X-Received: by 2002:a2e:3016:: with SMTP id w22mr3253387ljw.117.1570643834845;
        Wed, 09 Oct 2019 10:57:14 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m18sm619986lfb.73.2019.10.09.10.57.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:57:13 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m13so3381332ljj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 10:57:13 -0700 (PDT)
X-Received: by 2002:a2e:9848:: with SMTP id e8mr3209250ljj.148.1570643832712;
 Wed, 09 Oct 2019 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191009170558.32517-1-sashal@kernel.org> <20191009170558.32517-26-sashal@kernel.org>
In-Reply-To: <20191009170558.32517-26-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 10:56:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVe+nxotYXExXRxhvCSTCqyRuZUto6UrvR2oHfeGrJ+g@mail.gmail.com>
Message-ID: <CAHk-=wiVe+nxotYXExXRxhvCSTCqyRuZUto6UrvR2oHfeGrJ+g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 26/26] Make filldir[64]() verify the
 directory entry filename is valid
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:24 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit 8a23eb804ca4f2be909e372cf5a9e7b30ae476cd ]

I didn't mark this for stable because I expect things to still change
- particularly the WARN_ON_ONCE() should be removed before final 5.4,
I just wanted to see if anybody could trigger it with testing etc.

(At least syzbot did trigger it).

If you do want to take it, take it without the WARN_ON_ONCE() calls
and note that in the commit message..

           Linus
