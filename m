Return-Path: <linux-fsdevel+bounces-78747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KxILyXBoWkVwQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:07:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2F1BA899
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AA3A3096234
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3E439019;
	Fri, 27 Feb 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H+NvpbZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A22EBBA9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207989; cv=pass; b=ppBvaXCkSXGuwhVhA9+txGj6KNVfG6Io5CZxQ0Evw4A8Ell4mXimU03WL2XGcAnGs+uX0e3U3+RpmQZqQLMlFvC5uSg9mFcZhLDIu+5QUZZeCwt2RF7Nw0keGkrU7WYaYWu2E5IpE7asrxE4o8dficHd/VeeNnqpP87lfmP8sls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207989; c=relaxed/simple;
	bh=S6rWcZOFu0AjSm/YEvAiR/fRkIdVoRPS6G+jHr+6sfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/fsgFg5H3EYx7jlXL8XUr2mNi4TjYXnDVVW3eoa+BtIFvHQF6ZecnNBJQk80WP56QKLRIGVCrp2kllOC+7D+oSYB8vun6aWl47wEcXD+qvzDzRbTWOcaSiPelL6em2QM5HcSrq1RFv656BMO9W3bTizXuMUbkizMKry2MhmRFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H+NvpbZ1; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-896f8feee14so28619606d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207987; cv=none;
        d=google.com; s=arc-20240605;
        b=fDhluL96zl2tUIWohuNxB1sOUlVX38BfWCS4uN+ow3R7QPQAvQI+gOVi5yQH6nIx27
         ridTEyPITTwykVz3Nk6TRt/Qd1/hsSAY33YE1sPf4SDN17W3O8cy9sOPP1b/MNuiOqXM
         aVjf4O5GGxUidGgVotkiVq+ouwEN+//tnCLT0FV0tIhzOjQPdEhUurhYtrQXGc9z6RUD
         Xzf2gEirC7kniy0zjcub4uvDE+3LACpda+N9AplfkT57SkzZqNp+IiOhGh4xDZgHU0DN
         Nn0BqnKy4XGaSdLj14Y+9QGp+0qKrymEVkISAWMRAfSShXICFx2Rn2yUhJbOLvJk51yD
         Udgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S6rWcZOFu0AjSm/YEvAiR/fRkIdVoRPS6G+jHr+6sfo=;
        fh=tc5V5uRfmG8JvjsENfrchXujz5YG6eaBAA3OOK6bwvs=;
        b=cN3oK/d3UX7KbaXrtO7gPh0FJ+WMwn6/FkENw6RJ/SLHZ9BzucH0x7rbLu4eIFyhp7
         zbTlF/k0rEPrVf2Tn1uDjgdmSEQGZ9xEEduuQZe/+u29UBXZhEECeUE+6iuSFT6db0pV
         J/7/Eu32cygPKB1EL+SmQe8exFwbVl/SpJ4DiexD/CPpsqOwdJuo1j+ya0zDwlROLIKJ
         qAwxS6dXHCTQW7LBvJJmxlToz2AFgdsoUYehbutNlDQZUSNAxvUYjZrQTsS34rUiK75i
         k1e68Mih8T+IGt0E1YW5f1ZUsp3azO88iicNEHulWZEc6FMZJIwvUVPy7RBWGxHFdDR0
         rPYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772207987; x=1772812787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S6rWcZOFu0AjSm/YEvAiR/fRkIdVoRPS6G+jHr+6sfo=;
        b=H+NvpbZ1gzbjDK0tUshBrvwPGX4mhd/e3sdAwxWxIScuFKZrTtPGljK4ngaWDgu3r6
         yyPtROATxctyPzaBjFl9G40g2lDCtSaT4rhqWKYI+QBQVg4MalX1XL2jeDsSWPZCOXmn
         pcuYKV5jke+qilRtmcMkDyWiQ5F1PnjK37OnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207987; x=1772812787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6rWcZOFu0AjSm/YEvAiR/fRkIdVoRPS6G+jHr+6sfo=;
        b=uVpdtsRSiG889fnKP6g3H0YQfTGIn8uD6lxiVXRQ+mREAr4O8hwP/QQf5d9l6hBgLB
         zyGMtso1HrRbJ876M77xL0c7xy/CGf/HO3SvAVAGtSkDrzOQPJWT46Vt4fX0QOHLryyo
         oDe/lJGcPUachUzbF9tZKaLbIDLSwLpNfNoBf0t4EggR1y5l9MlzkV+5owkSjBElNmro
         aM0AZeC3gIT3agKDqTk0BnM09UbhBZP8KSkagBKJzycfmX5hgRN/pP7qxGgb5LcPTKIk
         St9VkV/Id0DfLCKJVWCc7ZZ1f97P+uLkSog4HoS3hqgyEVDeReqvjFDFKBL5SAKvAdbe
         HMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVpZn9zC4UsCksBzXWdRNSiBgbZ/2TmW870yfXqVuzvihCIvahhJiG8CqJNvxnROHGa+u9R3Zab9YyqWtcq@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUqTjvJZrOntBQ6WD/trXbQBzwq/zkLtWdsjE5toQYB5ZtEA5
	EtNib2CE4W9mkm1B82jHlLtcCcLsnwKAJs/3COLaZjvEttEgPUiSEFEihMfSACb58u2LAijWT0J
	CY9rjZ7Um94EnzvUvxxOHP6VBwAVCvdUk2NgQZ3Wi8A==
X-Gm-Gg: ATEYQzwrWFVnhk7tOJ1CPXpLFd3NNtqR5Ph/bdHyBNqTZ8jzENy4U+3hJkinYEQft3C
	WtT9dxEcApumUoJ6iwugtPP3nyYLdGRP3bYwlE8sCy8KvMAdPuyNbSKceouJ0LJm0CEcGIRVovb
	L/xudS3tjy/77J+Bdi0ykM+G7HPh2cLEWAQXq1c3XSLRc2CNggXrnnV4N9qxVph/GCxmmeAozTm
	Z32lh1L0Y3J1pDR2NWTVp1MeMrAU+UHBfEHnioAGPqy4cw7rPnv2dDHW8UDFNr6FTCOs0rPaA8Y
	ClMxZw/aiAT3VsNs
X-Received: by 2002:ac8:57d4:0:b0:4ed:65d9:162a with SMTP id
 d75a77b69052e-50752729a6amr37929701cf.34.1772207987064; Fri, 27 Feb 2026
 07:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223140332.36618-2-ytohnuki@amazon.com>
In-Reply-To: <20260223140332.36618-2-ytohnuki@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:59:36 +0100
X-Gm-Features: AaiRm516GpnBNvqwyyTtU8m-AWQqpXzya3lWgbXn6VfjXzTePAMXGdiNhw6uaug
Message-ID: <CAJfpegucMPVW1mEkRJrLUBuJ4pV54=h8S66U8H==qPmjEGwRPA@mail.gmail.com>
Subject: Re: [PATCH] fuse: refactor duplicate queue teardown operation
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78747-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 34A2F1BA899
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 at 15:03, Yuto Ohnuki <ytohnuki@amazon.com> wrote:
>
> Extract common queue iteration and teardown logic into
> fuse_uring_teardown_all_queues() helper function to eliminate code
> duplication between fuse_uring_async_stop_queues() and
> fuse_uring_stop_queues().
>
> This is a pure refactoring with no functional changes, intended to
> improve maintainability.
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Applied, thanks.

Miklos

