Return-Path: <linux-fsdevel+bounces-51973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A1ADDC96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17C216EE36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F12EE96E;
	Tue, 17 Jun 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5YXN5Ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736772EBB8C;
	Tue, 17 Jun 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189458; cv=none; b=OU6GeuQz53TlCn7Pd8ch1MpyjE9YvXf2Ra0FMR1ZLzLeuHFBorbsEL54/TbSaQUoMCzJDC0NkK5SOS8hpU3z/ILxWd8FWPROAHn6KkkFepXx4PT4UlI3nhAXqhcwJWHlraM4j475YcRuNzLhUn+WZzYCAQGZdHu7Ttk+mAr10Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189458; c=relaxed/simple;
	bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrsAdNPVr6oHJtRNSoB/EPNCLxuZevkqtSteFxJJkcOJwc85ci5VdBHqcN4z5q+o2y0zWLRJo+0T6PZlTNMPeml42xaCTnAXwIOFNOP6oTofjgmX6nBgYaMzfMijwI809CuU79W0y1KUsDJCsOr6yD+8giL9SwOxGEYzBUdePaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5YXN5Ob; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3900f90f6so661222385a.1;
        Tue, 17 Jun 2025 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750189455; x=1750794255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
        b=E5YXN5Obm582GbfI9FOMtTgUdCmShtSsAWCRc/66k+VbDOUCJPQOSvSEvMeVgAkiLE
         rdBitRc+cr0kjzj1KaEF8lR93TtH4OkUvIlsqKFhUMPGVVyr3CprkWF9Ic/5GtLC5tLP
         cYVn9+iH0bYvsUmkLblk3XGtWH4UmaTJlyMfYXdvzOjVN3T4mCjnAG5ibMeKIpITfnzZ
         15dSKnJIxZGVSgDpNfFXWFu3bc+NhD8Djm5c7Pz4FwZuIz8Lp/ZzfYJAbOo3i4veTkkU
         FMRXd2r45WP/IVMeeFLxA9cv82GdzszzAWF3GOK7cUHtwMj3JdQ+9RtJrq/OS/MSyhli
         Tx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189455; x=1750794255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
        b=IvsBIoJ4roe2Eb/qNWLip1oz5dEBjDedNDKbAEWxzp3ryqKd9uJXUrSrQTIvQszOzY
         JfuxqBjKcg3IXGfxi3WlLqBFkDXKEQ2h0FUV2zbEGifdJi7pX88V7STozAXmH0C+DxcB
         aBY4Dvjw0CQ2qkaWfyp2vKMndWNEqVK82lg15pBwDzuD5egf9ieMK5WLHpP286EOFS3A
         FY53Qh+dXkKtd0S0t+YKwSHVkx76LY5v5Wp3kNmnSifpAK0k12JWpDF2tZKfjK2WzSkP
         acj631ysQ3sm5p9dBSdeHGPwK37uWX0KIXyjxvPTBfQ42XKlB9r6A9TgAm/5GbJyjYEz
         ky2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZOv07xjccPm32JJcFwaqx5HgoszwjxtX9pRLKlcPcPlOs2As6XTPqcO4zhY9jfhsJrz7BVRRFxBRN@vger.kernel.org, AJvYcCW2yuZHNKmEq5oypi2sYg4Jfxaukwcrj+XNkTn9jeapW3MfDRbKu5jfSJocIJp8VsRwbkKo/TNF3zrVQw==@vger.kernel.org, AJvYcCX/ZTNazOwwNRjO50LLIJUK+7A9i7IMPfGd9GzckCMktAiimtFxXaA9l/RYEjV4K+uuNi8olx4Vjy9X@vger.kernel.org, AJvYcCXJ+m/ADQ1jzzUa9bZyMpRgQ4ULqYPWjeM1WiI7IVD3BmPhoNa2MBW32FdRQF1WCl6zU8gwzBNnpGLt0UfGXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycC+k799UJvQ5MQ3CevILPRRUtSA2KMVvgRIWDtIzys2ykGADo
	OcJYU0NiKDC308YVAwYl5oxopO42RPgwJT0Whmq5UsgLi+bE4yfbNvp+dqU+Q5uYNii55thubx9
	AbdozO6F7NgVI5Oe91iGW+GzB2SfQtEOd9GcW
X-Gm-Gg: ASbGncuhcmRWZxVXOJ8gbIC2SKrN/5wLirmUeGjxetRloJstD+/nPUfjlMRpT3Ktwiy
	u8SUm+/v1yYArzowJfux3qQtzDc+TRPWQXpR1OHSpNmrdCkALpUaU3Qesnr6HyrKMiKUcdsLP1T
	uMJmfhTz1N1Fk9RCynNrrJV617UCCMe/iLKvbBwiu13nA9h4esx//h+I+Vi9w=
X-Google-Smtp-Source: AGHT+IGguM90A5WxxBaJKHgMpi7W4GY/IAJU72MFE1HdL/TGwi0nyeWd9Ec3aNenmuUCOhCzBRC++OpmIdkKrJt7+34=
X-Received: by 2002:a05:620a:3727:b0:7c5:4278:d15e with SMTP id
 af79cd13be357-7d3c6cdeecamr2004479285a.33.1750189455435; Tue, 17 Jun 2025
 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-8-hch@lst.de>
In-Reply-To: <20250617105514.3393938-8-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:44:04 -0700
X-Gm-Features: AX0GCFtyYBSleZJx9jXRFkbq-wNgS1gcTjSW6ILPiwvxDyVA37lLb6eefOFCCuA
Message-ID: <CAJnrk1bdps-eetwZOu_2Sri7oeVAa7F+22LOjo=Z+Bh86drWwA@mail.gmail.com>
Subject: Re: [PATCH 07/11] iomap: rename iomap_writepage_map to iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> ->writepage is gone, and our naming wasn't always that great to start
> with.

Should iomap_writepage_ctx be renamed too then?

Not trying to be pedantic, but the commit title only mentions
iomap_writepage_map, but this also has stuff for
iomap_writepage_handle_eof, so maybe the title should be reworded?

