Return-Path: <linux-fsdevel+bounces-56955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D2B1D0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38115829E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F91E5734;
	Thu,  7 Aug 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4k4FZ1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220F1B424D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531263; cv=none; b=ndcLdZyNG49UqtcSBHWd99ewS+wp3Da5h/XZaOZo4wuhdvoMAA7K8sKGRTpOvndNnhn7JLvIcyaHJxuRZGNaQyT6gORt0c7iEA2nh+9/D9UZVIiF78GFyeb+gbolf01B0snnEUjnAodySJi8oGroWpgT9u0u/ft6DiuQ3nU1AnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531263; c=relaxed/simple;
	bh=3/ZBMbX1rfnr2/RwjuPJssXYwyCyUeok6+T+rCEfBb8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WOlGNDKFYQj77qS0xBxmSNm+8pfz2PQe5vLPq0lw7VaYv0y0MoMRYj2Y8nLT4Hr/uEiyCTQjpnn+lTsCZuA3gV4vrjqy8GN482ZfoniAlAUqbFC1BxhGoqn3MpAkA/2rzETN9PjarFDOGiyloCvtzye5mbwNbfbSV2UV6nd54nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4k4FZ1w; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70884da4b55so6149186d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531259; x=1755136059; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=B4k4FZ1wJZ26kcCyeGSrszGuKAKl02WCI416bWqISmNCYvQ6EK0AwLXxPrtiF/M/fm
         MF1URsmzdzSnjtufA6F0oLPbUx3DFAYc3mjPhq8qHsETHQtpzzA1uBK2jvfcuJAtWARt
         8psGtVUIPqJUEgVFmIQTLPiUStheypEhm4FdE8E+q4ECs5mrE2GFlspXgM/2UyotyEkw
         3h1N5F9N/dg0Plh2auIG28/P1Ux8s+lusU0xAMhRO/YymAXtDmme7kQ++SvAPv6xlKpb
         IUdfapwquOomZ90aZB38VYLfQ1S0aF+VAb/G72wwKKH5UtsJ84+lL+ziZhM77AY8qq3a
         Vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531259; x=1755136059;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=ouNkry5o+iYxz0D2rUTesJxzd82Y1ZWhOVlzu/fqeka0mff5e8bneb2bQgkSuHCJRL
         IWvFB2Zvdz+2rvnXw/PAZmY7FiXmW7vMG0Kz2QfuGkJmBy/FqkQq8EM530l83xOkBmFe
         ORyFgxRI3RyJQx/Cz59rxZuDapWa/ipPhdxG+G0f/7C1cJ8bA0xwEczbm7RDX5PYNQBt
         5zKzHxBZrMBvgIlBLvJmrgypvPqfkFQ7ViXJFxLlNuR1CuAigp6Ys7obENufKzQNhShU
         jCRVoTz3XkzTdGoSTEFLCkjbl3gPQApJCx1o8DLbIVc1tqP49PPKJXYVSDegjkjiBQeG
         OQwg==
X-Forwarded-Encrypted: i=1; AJvYcCXu/gu/GE/MpSSwvwS7BAMzjckiNpCPLZ07zm7km/kmupgUWA8Ym/fouvwag/aGDX9NWf3f34sOQeRuBI9A@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEuDg2qYSYZJYRpIVr9XfK9xV+NEKX21g1BGp72NQZth0CUbb
	XZy+DgvsPOu9gakWIrBB0fDExnV+EWcGQoouIBn0bH7eXpMmOyOKBKVxPGReV1egdg==
X-Gm-Gg: ASbGncuQypRdCh7Ps3kIo3OoMzJxgMp8hFIhcMsyyhSPXUuBGDVaQyG4krQKWgeYMOc
	ej81cJn5ArR96Zp7VS4wCMyLqicEwaSSHYsj4zysUJMomtyr+VSPURMc4dUy8qRuU5JF2nuWZ1X
	Y8XLI4BdcBhaA5dqJvQISyP1EzifJS9L3azmt2lO4YDJbDlVY5Dkno/dsY2GYd5wrRmcgbH8YUO
	lgsU9jzU7pN1hBau+H0caJ2DZjs0cL4+plpup5BmuhlcgEEE0lynMGqDONw8LUlGBNF/KPIPn/Q
	Kwx4BDSCTkfxKzex4/PaDmEikUCE5pPOHLfH/kptVeFVthOsBwLl06i8DhaUQ6uLOYIxIwIFRQg
	9yg5ItOSol/UHUmIDLmIHLemtzaTzmYUgF4ABhVCGmwgkUVmgr/XePRo4+Xd6saXgN0HXBeS7wK
	Odgg==
X-Google-Smtp-Source: AGHT+IG8gljUkhxjIhCTlEyvnsU1ykkoPiUWoXdbBKK7biBWjQdmiSFWNhS7Sn1nsxWyxlD0vdtbTg==
X-Received: by 2002:a05:6214:20cf:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-7097b055482mr61183906d6.51.1754531259574;
        Wed, 06 Aug 2025 18:47:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cd69b86sm93679226d6.42.2025.08.06.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:47:38 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:47:38 -0400
Message-ID: <74767dff9834360b2100907df5142ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence of  rules
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
In-Reply-To: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>

On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-9065
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> changelog:
> v2
> - re-add audit_enabled check
> ---
>  include/linux/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev-staging with the plan being to merge it to
audit/dev once the merge window closes.

--
paul-moore.com

