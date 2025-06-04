Return-Path: <linux-fsdevel+bounces-50632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E4ACE243
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709BC175A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760941DE4E6;
	Wed,  4 Jun 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbSfDh4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEB4C7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054971; cv=none; b=SdCIK3sAMzBtLjXw75pBnyO9UKY3OC4eA+HlD6Ck+H5ScAJorqadKucC7laRm4H1C3Qbj9whCXsxxCU45gZnrCizHOOMIcL+6Fb56bw98by2Wahw6c6qw4eFdPbhirCYDzndyyJR32wkpl/JheTVADHfv/JPqqlServCgrMZwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054971; c=relaxed/simple;
	bh=WqPDukYMiKBgpMkB+B4wnKpZceaDuz70VrmMbgjMV5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxHKL2rC4yhtUVqzF6yECxTVxbkO3l3b6Q5UL9txFOGNm3JPwrRx3PsllcATpXJjQIbFNEFa6p1yq0kMrLgiHYzEqiM8sSwwrLbUCG/QmZDt9jt5N+5FKkF9FJgiXZOEKvrkm2fizNVwl+H1i5Z1qGEKDJx79vB/g5wyOa2HRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbSfDh4C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad51ef2424bso9058166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749054968; x=1749659768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FILKRDTYsUdNifyCnOsNCvvlQtBAxB8kujF6zxHLJ3M=;
        b=EbSfDh4CaHK7uJYPe93JfcEaC7p8UnaSuYpQa3rk2/p/gLEO+bkXKpkpfKZqU2uTHG
         U4R/e2KvGvCD/IcdrgaAGESfvR0BCn/uJROS6mux3DNW46a1EU8X/7OKy+dO8qRC38bx
         Vmjsi1kUEBvyPtlAxijcIMvv5xK475mAeIYqcjFU2T+Xx3tHuf7rEVQIH0/IOCgTfave
         yIhHNpLyG9EyiFEr25VSqlYnSgwo0lcuXiNiFsez0LFX/SzaboFeOdODOfwlcQE0aVLe
         mCXcnARwNyxv0WVhpJcFVDtbnFkPMnY89/0NwGZmGDCFyth7bUOjxW5EejeRBJOhAdoT
         kfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749054968; x=1749659768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILKRDTYsUdNifyCnOsNCvvlQtBAxB8kujF6zxHLJ3M=;
        b=XPwbk2UmfaWhsUNYv9aRgycYJdq+ZBqLxFvnG1aB4YczuLPCS0ZI+uMX7urYeKrH9h
         93ibbRl83wJZej31WqQt5bCWmxqBEtQto1+iOevnAPtg+fvHok4xuvAyTlssH6xWTZsR
         mgbc3jSsKj4uzjAvvndKAjr0P6QkasbSADcsJVHtYIoQ23riUt/YCy/5NRfS9gGBobcY
         +IYrTs0irovoCar5CEGsjeZ+EOVfWyIVgzcE6wDxU5DAiTDGar5+O3/i+e1opPO/24wG
         Ts0K0JpgWJFicVDCd1uukBmA+0rL7b4JgWiMd2jOdoxQ0H+cpdF/rri4NQESKqTjaTFu
         XyNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVMWn2CmA3XhCFfdD8a5j6L0sSvL2OOzjUA5mDBJGDOA05LV3pySQYuE8FZrHTtXcv6Z5OfuoPXyBZ8im@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HyhL6hvzvBB3a2rDWfyrVzJvmWnLaNu0SeeJiIbFZb5ukc5N
	eJBYrrFu8ATk5kJjIvJ43b9VQyde2QlVFWvMUYD72+SSDbKwrzRQuEcIp05MMbnSmFvXNndlKBG
	/koM2M7XEk+sah1Ip2nBcqOP7vxDPLWU/IJ/Mm9w=
X-Gm-Gg: ASbGnctGGdywDREZQsSse/elMCPKaDvrFQY6OUpWizCGEv/aMuUp2PMNBePSY2SJu+h
	ZYi9f3Fxzst9FEFqe6ACgplEVjZ9IIaCzO+Uf8/PWiY0sJ46gmp6ty3poh/WqapYvT+th3tfx1Y
	c+G+5qCgJJCIL78c42y3YurQFx3+cOoLx1uwFQi0l1Rt0=
X-Google-Smtp-Source: AGHT+IF+mFbsWk61lcIdDeRcHBSVsgZko4FxznSfVhtEHlUjexF+lJA7X2EX+QK0+K7qdJHkqvM4B78+4nlOtMzRd30=
X-Received: by 2002:a17:907:5c1:b0:ad9:16c8:9ff4 with SMTP id
 a640c23a62f3a-addf8c9ad66mr346390066b.11.1749054968025; Wed, 04 Jun 2025
 09:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com>
In-Reply-To: <20250604160918.2170961-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Jun 2025 18:35:56 +0200
X-Gm-Features: AX0GCFs2aDCD8ZRseEsJtKQQf6KSTcil1dVqq8xe1AP8QI-r0Ok6xEBQ-Qx6tq4
Message-ID: <CAOQ4uxiXearwOZB-RLnCbJw8Lb-txavBM6H1=dyh7FJzWZwHjA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 6:09=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> Jan,
>
> In v1 there was only patch 1 [1] to allow FAN_PRE_ACCESS events
> on readdir (with FAN_ONDIR).
>
> Following your feedback on v1, v2 adds support for FAN_PATH_ACCESS
> event so that a non-populated directory could be populted either on
> first readdir or on first lookup.
>
> I am still tagging this as RFC for two semi-related reasons:
>
> 1) In my original draft of man-page for FAN_PATH_ACCESS [2],
> I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACCESS
> requires and is defined as:
> "Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
>  FAN_REPORT_DFID_NAME to report the names of the looked up files along
>  with O_PATH file descriptos in the new path lookup events."
>
> I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to ask
> your opinion.
>
> The basic HSM (as implemented in my POC) does not need to get the lookup
> name in the event - it populates dir on first readdir or lookup access.
> So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFID_NAME=
)
> could be added later per demand.
>
> 2) Current code does not generate FAN_PRE_ACCESS from vfs internal
> lookup helpers such as  lookup_one*() helpers from overalyfs and nfsd.
> This is related to the API of reporting an O_PATH event->fd for
> FAN_PATH_ACCESS event, which requires a mount.
>
> If we decide that we want to support FAN_PATH_ACCESS from all the
> path-less lookup_one*() helpers, then we need to support reporting
> FAN_PATH_ACCESS event with directory fid.
>
> If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, becaus=
e
> we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> on its "work" mount - the path via which directories are populated.
>
> There may be a middle ground:
> - Pass optional path arg to __lookup_slow() (i.e. from walk_component())
> - Move fsnotify hook into __lookup_slow()
> - fsnotify_lookup_perm() passes optional path data to fsnotify()
> - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
>   path data
>
> This way, if HSM is enabled on an sb and not ignored on specific dir
> after it was populated, path lookup from syscall will trigger
> FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> non-populated directories.
>
> Supporting populate events from overalyfs/nfsd could be implemented
> later per demand by reporting directory fid instead of O_PATH fd.
>
> If you think that is worth checking, I can prepare a patch for the above
> so we can expose it to performance regression bots.
>
> Better yet, if you have no issues with the implementation in this
> patch set, maybe let it soak in for_next/for_testing as is to make
> sure that it does not already introduce any performance regressions.
>
> Thoughts?
>
> Amir.
>
> Changes since v1:
> - Jan's rewrite of patch 1
> - Add support for O_PATH event->fd
> - Add FAN_PATH_ACCESS event
>
> [1] https://lore.kernel.org/all/20250402062707.1637811-1-amir73il@gmail.c=
om/
> [2] https://github.com/amir73il/man-pages/commits/fan_pre_path

Forgot to mention of course that I wrote an LTP test for both events on
lookup and readdir:

> [3] https://github.com/amir73il/ltp/commits/fan_hsm/

Thanks,
Amir.

