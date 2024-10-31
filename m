Return-Path: <linux-fsdevel+bounces-33383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809A9B861D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F5DB219BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8E19D090;
	Thu, 31 Oct 2024 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BuGm3Nz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347F1E481
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414071; cv=none; b=JtOD5jNA9N+sTOLagE3JUmMKqmUDJbYI18RqUgDxXxKdyV0IydhS150Ywn8aOLEUc5r65Aynw/33vgXUK1KYPOmDUj5Rwg/z88I6eo5L+irHKMWKzO7vWhgedk++3qZuEMXDNrqbHgQplbZ7Cm7bZRAC3BmJD8IIDoF9fgzu5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414071; c=relaxed/simple;
	bh=LXxLgzrj5/CRNUigUugN/QAkohEPT3VWSqb3wFe+yOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmsbXnLSCF8b2WI23Qpl4uOOusR44RSMoctJr7PH2DZTsbZxmK0vLKBjIUbbKQ8udTaS89zlAwWVxb5GEWRoeK3ogrzV2tdKpUiuTIaf+EFi8WvqZ6Jie1NxvLwWEil37zucNhO8NCg83WHGhM4Q1U15VVgEo6u7qgPBrJFxPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BuGm3Nz3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so1887048a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730414064; x=1731018864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1j9RkpONaFrr53NzZ106y+xSoMSfcVE5fFQ5IghjrE=;
        b=BuGm3Nz3sIncu4xfz6M5xMZNOqMBg4fhPwvM+uUb7Swan3scxGBX5XZg3dzygg3grw
         7+AtnJXu+L6oHZVWj8kT8SZyHSXOOy99NIwTPFzZUgXb5wRSyfg4HYf2bwhcklAv7Cpm
         Nh2LVkACP/y8WjPBqzJBg7LMfNqp+BWRphtX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414064; x=1731018864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1j9RkpONaFrr53NzZ106y+xSoMSfcVE5fFQ5IghjrE=;
        b=oZ7tTpNA8AJqZ0GcHevZ8SP1y4PikWFi4g6qzM5LjmTICgllhC5i6d+F4H8aIDkMhc
         zGvLUxCKPvcGCcPwZJSoBoDuUhrN3O4IkWUVfiQFh6rQ2iICRO9j2Dy0eoybZ910lwhw
         S++m0CYA/tPGM6BbA//dfV4rstX2qrhPgAJ39SFjDXGlP4D5Y7SiHb1fAzHj8ffLuJjp
         HDKghnRB9GEp812j1udrhqno0wOUX+HpAcrDGXyGLHyLv4Fkk2CEhjxXilAVd2xSVZav
         yxbZIMUGnWBID7Vq2pdtAqFJUrjAXqHefxa/e0gyXt7geTLMULby8im85ZeeEiNQx2ec
         fijw==
X-Forwarded-Encrypted: i=1; AJvYcCWEP5Qarv22ADA3LDVqrMqLmSV9pk6OCngvViOEgVmud+UhJkLPPjD3z1MZXo5i5ftpMl7DqzXW49eSJhV8@vger.kernel.org
X-Gm-Message-State: AOJu0YyJi/VDvuPbPMMzm+KkZJgCZQOuVGvSAujd7TMZreVxV86jllHM
	R+ZJZzUsKowZbGIZdEoFhsfABMkBTmR/zsaiFu0tb+1jd7RmLBlvDRSdtOPFfikK60B309iGLpD
	MC+0=
X-Google-Smtp-Source: AGHT+IG+FpHhWMCth9gkVKa7LR3VsNv0P+eqKTkcvPfzkKQ3ktgYdp5QOuHbVCDe9Z5dyJldaLmyCA==
X-Received: by 2002:a05:6402:4316:b0:5ce:b82f:c4eb with SMTP id 4fb4d7f45d1cf-5ceb82fcb42mr1713170a12.8.1730414063981;
        Thu, 31 Oct 2024 15:34:23 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74cd08sm950987a12.2.2024.10.31.15.34.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:34:22 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso212725466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNwmjFDU2Q1yQplcQnbUVeIDVOAw2KaoxPofpmUURF0LGLOYlET/pTnWv0CdMSLHOrO7riTyofDOmtSVZY@vger.kernel.org
X-Received: by 2002:a17:907:97cb:b0:a99:92d3:7171 with SMTP id
 a640c23a62f3a-a9de63327dbmr2025448666b.61.1730414062548; Thu, 31 Oct 2024
 15:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV> <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
 <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com> <20241031222837.GM1350452@ZenIV>
In-Reply-To: <20241031222837.GM1350452@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 12:34:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
Message-ID: <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 12:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, patch looks sane; I still think that adding || !IS_POSIXACL(inode)
> wouldn't hurt (yes, it's a dereference of ->i_sb in case when ->i_acl
> is ACL_NOT_CACHED, but we are going to dereference it shortly after
> in case we don't take the fast path.  OTOH, that probably matters only
> for fairly specific loads - massive accesses to procfs and sysfs, mostly.

Yeah, so the reason I'd like to avoid it is exactly that the i_sb
accesses are the ones that show up in profiles.

So I'd rather start with just the cheap inode-only "ACL is clearly not
there" check, and later if we find that the ACL_NOT_CACHED case is
problematic do we look at that.

           Linus

