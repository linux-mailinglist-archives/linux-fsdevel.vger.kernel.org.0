Return-Path: <linux-fsdevel+bounces-35643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEB9D6A98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628F8B21C96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0815B0EF;
	Sat, 23 Nov 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YhaQKd+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FD146588
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382969; cv=none; b=BhFb6milt4f//cTsoxZ34VBdnRecVSWOb+42GLz4ZxpuKlFh6j/dLsDOwB5Jh+eTZHJcY1nzSa4TqbH48MQnbV5xhxkCSxvI9DENUXaPv4+f5y+zhxfn78+1a5VX2hC0qptXKxD39sOhRm+uE4wFAJrQO9ZTpgv7yRU8NPwxlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382969; c=relaxed/simple;
	bh=JW0p9SO4wNjvfWYrh8A4OxTL6/rZR0ph+y4ILjPxPlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4SsNDpQp3gIDJ6G6uf9cMKb5u1BkwTJsFC9zEuyjNabcRp9r4DuSdvINn8cmvdhijLLa6PVSuM5Da/74R5TCpBA6Koa8F74wrIhkl32p8sOCr9u3BcdOhO0pn3Romtr2Ed6zDpF6Z/IYQe+rIAhMvT/105Jb+pVtb5aJkazKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YhaQKd+8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so3717564a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732382965; x=1732987765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vCmemIQJAyBLtyohdE3n6qmf1JVeKEXVkWL++xifbs=;
        b=YhaQKd+8gO14MLKy18HUJtp8kTqyPb7xy8YzQjROvw5t7cN02GnSUHFOj2karQR7Gz
         sNsHz+CgVWJTb4ZppUwPEOkDTk92lcSdX+gDsDJx8Solug8rHw7sDV88eKOQvuHxPSF+
         zVRGolYTeg5ABEp0mQqCwi62V5ZvlOdVmp53g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382965; x=1732987765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vCmemIQJAyBLtyohdE3n6qmf1JVeKEXVkWL++xifbs=;
        b=tsc58E0fGCeY+ySlgJ+ZQecQTEMWdzPu8fhF7LVmTAR9UGJAdrVOHe2n6BM+N/DjHZ
         B1HyrC1Z7T3QNQJPVvBqrEBW3kdz0D8+wBFGFo483yYgvn4iDy6+FyNKNLKiOvYid9oc
         m6hSlnjWwI9wuhjDn46fwzRF+Bin17UaqLKHJrUv93hT749Oe54D7RnJg1XIkYMQFD3k
         P4F2NbLxFdlMftmry1kmjRx0FwQKO6e01zPr69sjk4MGzrRtgkZ0p29AnrJlgDt6qbhz
         o9nnZCTorL8BqtKyT1Qgz+i29+f6cSGy4s/3QKF1zwGjvts09+Vy4/U21QQbQ5zKk+kg
         tpvg==
X-Forwarded-Encrypted: i=1; AJvYcCXBfRqCDE7tYAn/dNgzirSn/D5Moom0C/aIdwXyrUtXrcy4KuNRPBgbGAs0u/iVy0CtDsaOgWcusvcrUHIU@vger.kernel.org
X-Gm-Message-State: AOJu0YxcI7Y5IuUwC/qktG6OWXHLx5c4TOq79/7OvQ7M/NvXrcZYTXiw
	7v7krMROl6yfS2T3thA2nrsxdb9foHeiyD1RgFAuVs4Q8cqBzsxCCsznCrTgLPS1iXJBfffnGEN
	xQ7D+3Q==
X-Gm-Gg: ASbGncuqOBM/cNs2xSoYU43QUodx4S+DerbycsQOZLC9TQ1tvy79G5PiJeeL/p++9wL
	GeyMjPFkXE91U3ndtDaDFsYF1zDtMvbtJrtPzhspIfj0u3aJ7Dm/+/mv236suZ5XXyMbujwkRFH
	n8QmWCqlFwFwVGHFMJCXHamjxxDnnuA4F8gPiWsZ+w+3bqMiJfJ+WMOn5yOOfB+hPZu96NqlOpZ
	uX1SC6R0lpue5zVhc9Lu7jn3Gw/mJFhXlGtimjvWqI5OwejQcFz1VGjiDiUfZYcQ/jJcmPlQx7W
	cBnzOR3J7qOrPGYJQJ7iVXKp
X-Google-Smtp-Source: AGHT+IHcMytunQ6eGxMQqgoxCsPUWywhaXdGc52UptBbQr6Xad7bzEG2nSP61dzx5kJ++4/5FdW9sQ==
X-Received: by 2002:a05:6402:1eca:b0:5cf:c97c:821b with SMTP id 4fb4d7f45d1cf-5d020792a11mr5837422a12.23.1732382964738;
        Sat, 23 Nov 2024 09:29:24 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c040fsm2214371a12.50.2024.11.23.09.29.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:29:23 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa503cced42so277464366b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:29:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0kOpGBJnaxcYmWkf2B7EyEPANwJepguVT04ZJ0alhEFjQoekwQZU14AQOFWqT0+GGtH0rHQD/5yarxkmb@vger.kernel.org
X-Received: by 2002:a17:906:9d2:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-aa509985a54mr597055366b.36.1732382961227; Sat, 23 Nov 2024
 09:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <20241123-bauhof-tischbein-579ff1db831a@brauner>
In-Reply-To: <20241123-bauhof-tischbein-579ff1db831a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
Message-ID: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 04:06, Christian Brauner <brauner@kernel.org> wrote:
>
> So just to clarify when that issue was brought up I realized that the
> cred bump was a big deal for overlayfs but from a quick grep I didn't
> think for any of the other cases it really mattered that much.

Oh, I agree. It's probably not really a performance issue anywhere
else. I don't think this has really ever come up before.

So my "please convert everything to one single new model" is not
because I think that would help performance, but because I really hate
having two differently flawed models when I think one would do.

We have other situations where we really do have two or more different
interfaces for the "same" thing, with very special rules: things like
fget() vs fget_raw() vs fget_task() (and similar issues wrt fdget).

But I think those other situations have more _reason_ for them.

The whole "override_creds()" thing is _already_ such a special
operation, that I hate seeing two subtly different versions of the
interface, both with their own quirks.

Because the old interface really isn't some "perfectly tailored"
thing. Yes, the performance implications were a surprise to me and I
hadn't seen that before, but the "refcounting isn't wonderful" was
_not_ really a big surprise at all.

                        Linus

