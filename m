Return-Path: <linux-fsdevel+bounces-40007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C2CA1AB90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAB5188C6C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C01BD9F9;
	Thu, 23 Jan 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P6LWrTb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB815A843
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665228; cv=none; b=p8l1knn1Wl4cOLngnCP2VwPDwWKrKCfz0gstBrsEKojqUme8eynyz1TZhD8xSM1NHIa3XUFzG4J4j23qlRpWN/IgR8hSGWd80ruX98N2fch4r53YNW/JnwxBX2qnMyAvB8ZW3dqc4rO3JzYl0AZ8TVCag2cd1l5uYoddXM/4NLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665228; c=relaxed/simple;
	bh=KSB8Kp7EsHfrVZQY+SXlup88JVP9yyybJ/L/QaYGigQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7fghzCHsU/izuzP/ql8ALgUUNf2nLth2CNXozNOO1EHbdiu79YCFM8Dy4ejs4hjPQV9HE32VcRJ9R9XClvoAiqoYevGHyUngrAB03MH9/k2PKvQry7nn5OwQikadQyWKyIx1tQt0lLz/Yl2i8w+5RoZmm/BP6xTMYSOIObeQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P6LWrTb4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso245078666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737665224; x=1738270024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swhkuw2IJC0VH7sw/GAoE4rlKpYnSdAW6AVRyqLV/Vg=;
        b=P6LWrTb4iK/4sUdL8W8EBvBXrmWhf9Dmk9l07dU6+YD4aGruA5ZnoCgUWJ4V5XHyMS
         6zHwEOpbWlkE5fWenpYy/NUrMq4JQuOwucH7ti/Zg0sOAxWYBam30uPetrsjQR3qqVP8
         V8njYhfzsK1uqSONejlwXsYEsy7SIXxtwJpBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737665224; x=1738270024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swhkuw2IJC0VH7sw/GAoE4rlKpYnSdAW6AVRyqLV/Vg=;
        b=FrrH0FkuCnPzQ5n26mOnwbiAClc3IO5Zd6V1ozUNJlTNy1hp/q/CD8vA90dITbuxL+
         2KeYZ73qsYzXsHJZiAf0nCi8FIAeESTCWrYBvX8FiXB425sKa8MDUdtfX6UqzxmcZraJ
         HPOe81nauHCL/vo3jQzcxhcV8kLo78FGU65Wo9NkcfnjgfpEAYViyBzfToyu6aumU6XT
         CWlcivCjuaj3vb1EjlqoQOZWkU/Ys5FG4Ds0Yg9d88KbCWPJ56CJLfgQ5kHwlTIFvaW5
         OmcAUE/OMj4j40P1+u4lqkmZDSCPmq2iHvlOSFAzW4jHfflwl1FuZorV8ZYKXKQZKR67
         9BvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUHJ+tdOD0DguZ7OcS3t3qTkn71MrJ12Xgw6AfVx9GvEEySGoTQkARpUGxJhBIsUUjTStuXIfeedPFF7LJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo2Cxh1O/QHx/R56gd7wpVNb8NY+zR5T8ywtEc/V+OM2ikQ0b
	24tFawMk3itjzjFffodNsjfnJdjndouKggrd6WqS/7TdpzYCwwD0Dq3qvE22v+VW/cTL/drxthV
	lGF+4hg==
X-Gm-Gg: ASbGnct7R113jCpIPAZhtB12npp1MuPHvldDMZT2DlYTPKwa5CWXI2Xy6adlfnhL3Xn
	BO7Va7ElfCtIzhltoj0FB/JugLGfCz/IEP23WQTmG4T6L0G9vlVhSV4m7lSCXDHQFeta2cSe5lD
	s3ARGW9Qa9Phsv4cJc3sDaQpbpjtQfgBlWXLTg9LHtEEO/ns4oKLSiKLb5KoHjveKBvOsDHLFjb
	f12G2bKc1KYT7RORF6oIxQzwL7R5lTVyWWB8T9EHWuSaKIF8p8BqkQC0y5HgyxGMZW9JcZvIJ+R
	HyqM4R3sAIMZrTNXyJn8bT3UvVyfLirU3SIHI7exIKNOI1iAYX9/k5c=
X-Google-Smtp-Source: AGHT+IFJhbv86EggrkaTpXjqbG5dLEtSqGiU7bHrA8l/BquWYvExaIkSIfw9uwIm2cBbSBi9AmIujg==
X-Received: by 2002:a17:907:7da2:b0:aa6:8a1b:8b84 with SMTP id a640c23a62f3a-ab38b5342demr2827780766b.57.1737665224375;
        Thu, 23 Jan 2025 12:47:04 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760b76b7sm14574766b.87.2025.01.23.12.47.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 12:47:03 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeef97ff02so264331766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 12:47:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvo+pk5B4+PpYNbmG5k3QyQE1KRc0MYIlt8LfUKVJSOelRa5gqK95bag8dMGS4LK/pdyosa4E2jerx4MhE@vger.kernel.org
X-Received: by 2002:a17:907:1b15:b0:aae:b259:ef5e with SMTP id
 a640c23a62f3a-ab38aedb10amr2909641966b.0.1737665223126; Thu, 23 Jan 2025
 12:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <i6yf5ledzs4qdt5zhrpg7nz5neyygktthupap6uulpuojcx7un@phdanup4alqb> <20250123183848.GF1611770@frogsfrogsfrogs>
In-Reply-To: <20250123183848.GF1611770@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jan 2025 12:46:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUe3wH4J1YGrdokVEgtb2hjteOdBttF=6ffHSYzakcBQ@mail.gmail.com>
X-Gm-Features: AWEUYZlD8a5D9sz4IXksbiDpEwskwuldR2mzMQR5r4tlOyWh8uFjh53AEtyDrzI
Message-ID: <CAHk-=whUe3wH4J1YGrdokVEgtb2hjteOdBttF=6ffHSYzakcBQ@mail.gmail.com>
Subject: Re: xfs: new code for 6.14 (needs [GIT PULL]?)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 10:38, Darrick J. Wong <djwong@kernel.org> wrote:
>
> It's been a couple of days and this PR hasn't been merged yet.  Is there
> a reason to delay the merge, or is it simply that the mail was missing
> the usual "[GIT PULL]" tag in the subject line and it didn't get
> noticed?

No, it's in my queue. You don't need to have the "git pull" in the
subject, as long as it says "git" and "pull" _somewhere_, and the xfs
pull request email does say that.

But I tend to batch up merge window requests by area, and I did my
initial filesystem pulls on Monday. The xfs pull hadn't come in at
that point, and then I went on to different areas.

I'm getting back to filesystems today, but since I have great
time-planning abilities (not!) I also am on the road today at an
Intel/AMD architecture meeting, so my pulls today are going to be a
bit sporadic.

               Linus

