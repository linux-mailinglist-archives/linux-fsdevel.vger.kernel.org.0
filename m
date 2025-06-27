Return-Path: <linux-fsdevel+bounces-53129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02186AEAD40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394C83AB05A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 03:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFE19AD70;
	Fri, 27 Jun 2025 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BLJbSaeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECF1990D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750994505; cv=none; b=uwypx8eYQFlFt8sApi0uKQ7y+8MnR4Ke7sUjPQ/9i9QnZhas7ciOlNIe5oMzA/TuJGfgG7Q8F2Ed9gbyH4LTOIiZFohgtqyM5mi0i56W/1WTWBdxw4drphLr9IbEzHN0VfmZEXdSdj+ci5WNFv1dn0zFEV3Wg3xAyyilFPnZWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750994505; c=relaxed/simple;
	bh=he/hLvBnbigWw1PXd2xIzILnQ25Qspezkj3wSUZr1uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndWUM+wPTSQEtfKKeP7EGbWGOMXXqVsaavZrDnp6smLHitslXQU/VonJ5M1SNibNiBM3KhhLE9ph/mV0tRaqm7Aj5aJLVV8NL0EOdpzUn2IW6BD9yrGkF+MT7CNBJe5SXdIar8p3DQd5Nmkrcrk88UQG/eZisXw1zoxHIJIIHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BLJbSaeW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade5b8aab41so340530266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750994501; x=1751599301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTgFywLZhfkURPzWKiCPE+DZDgyApKxE5NQzTKN2sIc=;
        b=BLJbSaeW3X6x5WRfX0pmdrbsWlz4pKBDnEWkx27F+hQlEB4hFekgzwRFXkwj9AgS4D
         MKd9I/0BSpzZatEJxynujFumhibU79EQtY/qavpO32v8+09JHQpDE+6pm5hlg8y7HncD
         J7A0NJ/6UcGB3lP2xjIt733yCZhhpAIMVBxgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750994501; x=1751599301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTgFywLZhfkURPzWKiCPE+DZDgyApKxE5NQzTKN2sIc=;
        b=ioaS4YDG7l9A0ffDdy3m7wUHyXFJAEZZMWiT4qNJ6NC5rSW+U9SVUm2DYRKk3PQK3e
         Y1k1xleyb03DX5khYbJexG+3lts60LO1xOpZgxhpcZL55z8YU0uOpaKlwm1anWjTwneI
         GLiZBNXnbMoBijQyp3hdjQ3CyHa/NYpxEQeEw8t9EuQxCPRbRHtmO4yHi2FHKq0gTCtu
         aH0O4OsHcqSMTrvUoOWM6W1p4zkmVVrnMVam3JcKjmtdQFr8sD8CXJM79dgzNhIgNud/
         RmmLVyJnE8vB38Xw+TPxBaVlYAO+vM1LdqBogm7zPdXH8q9U8ASu+bsZ/UbcV+LDJ+kc
         1Lyg==
X-Forwarded-Encrypted: i=1; AJvYcCXuuaneoePA7oA/dDF76rOCyrdiVEEzFSJY4EdhS8bd6o76+cjhq43Lsf3OmRIYNjWty+UhhvQat1sQk8w3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ySWFLQ2ge2SPMUl+j9O8KgEngZlFIPgqcxUti9sS9DeZJVCu
	NnlUKhrAdJcnbr1pJKowdwm4+EhAQYnXmjxCG00mWJvsQh6PP+vxfEuOwJDLPpka/zovOMCyxnz
	lvzId3hw=
X-Gm-Gg: ASbGnctEV8cQijy+Eaw8NOYXoY47e7aUH2ijeimokSG2xOskp9Eyr/9UMovcxGIUgeQ
	3EPinZJhNC+YA5VI4p2YqNF9h98FU/gwYbkVpH/DkHUJ72TXvobwo1OEpCPUQEK1/o2NYHXTHhC
	k6U0jYGMj01f+hidl9bJgqnZH1q7n4cIsUEnToePVkP9GETYXq+UTybaPy/dzGexjGQWqHXYwgt
	zQOMtT4neXiN8kkX9E2xutRVUkTmAu+gHnUkq4L+Gt4eVRGU2lWlCQ/3L+b7FtfifbRmVCpRo1g
	Jm4up8tGAtpjVQlTOzXJwdEnrD8QURuYFWaZYBSMuvJffNXr4lDCKyoe9l4aRHYjprVkYgVAmdg
	N7a+59rB3zGlQz1h8Y9Qn51GcjWpqB1k66ULm
X-Google-Smtp-Source: AGHT+IGCz3fUXFLCuuOdP7qOJ7uC7nXWcdrWqPCh/q805uBPdfaDpHO5Cb/TMWsnxA3tCNGQh3Q9Hg==
X-Received: by 2002:a17:907:6d19:b0:ae0:b847:435 with SMTP id a640c23a62f3a-ae350129c6dmr119089266b.49.1750994501139;
        Thu, 26 Jun 2025 20:21:41 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bfa4sm40681266b.139.2025.06.26.20.21.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 20:21:40 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so3299267a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 20:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV2wk1Oet8DSL4xwYz2vvd/YMy4eLotssShvLEDhHHhgQvcr5i8mxWAi25jatjg3waXp0DUT7UyjEJwqTU@vger.kernel.org
X-Received: by 2002:a05:6402:5297:b0:607:eda0:1697 with SMTP id
 4fb4d7f45d1cf-60c88b482a9mr1301078a12.10.1750994500083; Thu, 26 Jun 2025
 20:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
In-Reply-To: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Jun 2025 20:21:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
X-Gm-Features: Ac12FXxm4LeLk-R5TkNNlVw728828csptX0fmReoyGbOww62X28y2kGKkM02SZ0
Message-ID: <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kerenl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> per the maintainer thread discussion and precedent in xfs and btrfs
> for repair code in RCs, journal_rewind is again included

I have pulled this, but also as per that discussion, I think we'll be
parting ways in the 6.17 merge window.

You made it very clear that I can't even question any bug-fixes and I
should just pull anything and everything.

Honestly, at that point, I don't really feel comfortable being
involved at all, and the only thing we both seemed to really
fundamentally agree on in that discussion was "we're done".

              Linus

