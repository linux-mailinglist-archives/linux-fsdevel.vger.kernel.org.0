Return-Path: <linux-fsdevel+bounces-10675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EEE84D570
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E1E280F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F121384B1;
	Wed,  7 Feb 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Y9aMcX5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBB12C543
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341617; cv=none; b=LdXjm7+IeEVbH3TnafFWCj4AsF0y+4BCYi0sGWii9N8W0m1IbMX8J7U5UUOAcUk5tbJNl4dIGOocoyRf9M06n2NWguZDWvodIzVlKi5rA6rclpXcl+J5FUnQbziOOaYTNSRakQ/WBIV8ppdq9NxBgpnBnTDNmtt1lMyUvUtMGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341617; c=relaxed/simple;
	bh=6BOpcg6okTWPFWaIYtqUARu47dDdOBDQsvIoMbwINeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORht/lvZNZwbXrl4oDebZtBygbMpCeE4/AklTN/xalLAmRKFz7hnJ4QKIt3nXjv192uPEQKDHWuczv9x8brZxYHaIehUA5n/CuLO6vyMQ+iKz0KNe0IO6re5OvyHXNnu+9/5kbcmMFKP40CYLIPpjtqO+8kEhmMmgGq9ImvHJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Y9aMcX5W; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc730e5d88cso1145133276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 13:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707341614; x=1707946414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BOpcg6okTWPFWaIYtqUARu47dDdOBDQsvIoMbwINeo=;
        b=Y9aMcX5W2vl/VGu0yDEs+EPk5WXBHeaHsV7WH5dAo1UtFcSmkB9ibDRkosr6ZgW9xD
         2r11FustAYoTBnt2DFhfYN5yB7671yDlPzSN9o7h/IpXi1k+OFhkSJM+NE/OyCSiNJgv
         jhlt3fIKps099WYsPRzHjyno2zvkRaDNpkwg6sCiHq/NulrnAijIOVeYrH150MeyZYwo
         IBnyNLa2V5ZLolWAlZdg+21EwzHyL7fnOgP/iZCFcxQxN1KcTkssH7C/MWZVHOM14ofn
         dkCeiPZr/glr3FxxM20e27b3cqmOkdZ9xBu8JqwH3Sn3cdIk7LNV++i6M/NlvEXfC70R
         Rv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341614; x=1707946414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BOpcg6okTWPFWaIYtqUARu47dDdOBDQsvIoMbwINeo=;
        b=R9NbHBgqokOEGX/i7PmATR0YHbfx4Qk3x7gGMWl9C4cB/jnLxOeR6nQ1GVOFo/6W1F
         RH1+V2ZVU+k7NNy687xdtVegD9spRbqBPjKHTA2LSNhm25u81Z1Wq9WgxD2rv+i1+ujL
         MthXfFtOWGqE8mnK9EsjIPNI0T9oQjZTlkqobp+aDobhi2X9RRrrMAXDnVTH2+wnnrZp
         WVcPi39Qx9mCfx6rvuGQFJVUwzfJ/jqmLC/MbYkNBqf/1ymsW+QWX25kJE4DD1y+VKGK
         k/oEs1aGxGYJ5nVJDBl4OgJApQNS4BM0wS/i+lbiuKGqqlBNGbyRF/Ggk+/+T7zprHnO
         xOuA==
X-Gm-Message-State: AOJu0YwaW/IAr2pb3BXFPWZzhP8/15jM/QFnUj8Kfvs0/J6hPx2Q6fjA
	s0GtJDkAepGdWEsAbWATA0ehEMrLCAJqWsQ9O8qVb0s6E8edwwmxP0qUut/TZCub+e8NzfdZ//A
	DzKqp8wT4p/Slbx1equT3bkgX9tLbfj6TSMMWc+rJSHz74xmfmx2s1w==
X-Google-Smtp-Source: AGHT+IHrYG+/o7v1J2J3dpFwsVemFTwS1qmwD738Z1mWPeHiWxDEFgNdegqhyiNG9Feb4jofcWgOJdbWEuL4wTlAYM8=
X-Received: by 2002:a25:fc0a:0:b0:dc2:53ad:9a3f with SMTP id
 v10-20020a25fc0a000000b00dc253ad9a3fmr5899264ybd.27.1707341614524; Wed, 07
 Feb 2024 13:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055558.611606-1-tahbertschinger@gmail.com>
 <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com> <qo637rxuw5tcskmgubutpe6dfmhhms4d4pjivzhewl5tpg3eth@xil6gpcvdiya>
In-Reply-To: <qo637rxuw5tcskmgubutpe6dfmhhms4d4pjivzhewl5tpg3eth@xil6gpcvdiya>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 7 Feb 2024 15:33:23 -0600
Message-ID: <CALNs47t7AumxuhUorA9XRhd2s46Gu25k4tiX7RtCGxKhnCuuKg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bfoster@redhat.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, wedsonaf@gmail.com, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:57=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> [...]
> I didn't see that comment, but we're mainly looking at what we can do
> inside fs/bcachefs/, and I've already got Rust bindings for the btree
> interface (that I talked about in a meeting with you guys, actually)
> that we'll be pulling in soon.

Is there a branch with the bcachefs rust rewrite or WIP, whatever is
intended for upstreaming? I checked at [1] but nothing there jumped
out to me.

- Trevor

[1]: https://evilpiepirate.org/git/bcachefs.git/refs/

