Return-Path: <linux-fsdevel+bounces-78802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MrGwK9kcomkqzgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:38:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C721BEBCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D450312C76A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B693859E3;
	Fri, 27 Feb 2026 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyfZiB2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E43D4118
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231729; cv=none; b=tME9k4F3hTQKx+BbwrdCtQRGbyynUMD4K+RZv4TvWX+l9Y8OoCRo/Hj72IfeXgoKcbBKqRZFiS9lLuBtrVJHD+xE7hD95fcSxjegXDo1a4fUTi1/Yz/d/WxXYP3FZGzhvUthXOwMU9SGH/LjR5B3YE8z34PdbOxSDmqSUna5tp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231729; c=relaxed/simple;
	bh=bvvF1sfeO0OrUxbSoQYtyRk/sV5o+XzBFzSbTrzIk60=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=AGDYpTdNZYbRVBbBAWCuekOE4YfN49arSA3ji6YYR1XG+VjTkEGpiONb49c7wXC0bsn2ZIML/wu3EalZD0u6paprsVD/aK/CJCkCBOBlnyVu8r1WB+TKaspPIUllRple5JDlId1EPEh2AVm7SPMANe6H6c1AAZNns/3cw5WMnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyfZiB2w; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-827336c0994so1708669b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772231727; x=1772836527; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FpqIYj+15/j3QcGVpMOftzJrXM1/vX1ZNGSvGc9WPwE=;
        b=EyfZiB2wUonEgfIH16FkV4PhTDJVkd+qGHuCLZbjKQQ6v0XQ4e+PDuZsbwL/EmtHJs
         /ClTnppQPDbnuchmZUb/ESAX1Dt+xFz9hq6bCGruQNgw1mTumqtbdGZZZHBjLeC5Ph7Y
         H8mDzTIp17Ls8tJRijKCPsC3e0aT/Hgt4Hsc25dJhrcRo0A3XPZYaX3lMvOajCR0CA6F
         rPR4HzSQKrgefUCTYlqrglwZCp0biADnXfO/BoyAxysB7bcHyEnPYjl0DcyRD9+G0S5m
         mhEwhWwr6vIDY56HF46UgpHAk/uNvXUA2Ga1Baelv0clEZ1Dty6B9nLdKGtXUk4Qy1Dh
         om4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231727; x=1772836527;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpqIYj+15/j3QcGVpMOftzJrXM1/vX1ZNGSvGc9WPwE=;
        b=AZg/i2t7sFg7rgJrZHDkdOND4Nf9sODDJaf9QELTLTmNruqvcwdsHB0Mi7adTqXryY
         dPekc8WDs2Zz9eI1TVSFfi4NUeeRFkRTQ0Z0qeqbbtf4GswjeDUfitjX2bgYMRgZrHmR
         UP+/emqlPCnfWjXFCyoa4A9TIYCHsKIuj6mDus0lwrFi8TPS/i0VksoGW/4guzS7md6Y
         HUtIzcV1vfRhGDX7fCe425Ldzf9/JpEsccIP8yT5zHXQcuV139ne6C2d8qeUdsZmc21P
         5nVZ2mauCEFcITXlo+xnrUTekJpF9+4+THfF9MqOEczZKRrfFiaQjI+RBpvfu/+V6MxM
         Tx5Q==
X-Gm-Message-State: AOJu0Yy67clasDd+y/y4HP42qY4B2sf3ri9IQqe62GUoWQoCOqffEOfX
	O4i21InTWNpgysHwAj4gU6gMuPCD4AIjCrEvUsZtNXgnPxVXuHtVPL8Bz8YxMw==
X-Gm-Gg: ATEYQzzhYiq9P8IzUvNVpfTZOnogkaqcjLcCWDfjTVHSJVzWVheHTaybueO/EnanEuS
	f1Oq6b/eGtbf++Hrk1CAP/z2Y2b4EJKtYPr7ekgWhyDo6spHTxOFDXLY17/Qy349d6QMnhP3FWf
	KizLB87wM5OwamObfN9tqOz2WN/bGSL7HcbXkK+Ssrk1s0gjcB+Z1Mpqpie47l9GgmtCDZa4/i9
	lGIIgb98/EbhxvqsyzudrHK7ILXHIj5dpcZuVIegOIis/8MP6Pq2lJfhl7uvkmuXpHqmBkNEJTh
	m2gAhaSypAV9rNXBoX7OS7lpRLQ9m627YAP8VXP9iL4N+f10BeZ2QSsiQW9Y/DK/WtNl3FEih/q
	mk4BHgRL0GNB7NUxS+s/opdpmovbC44fLCoDBQNVB7VFZcQLyR7qHXZ2WRyWnSxwZpl3yxzJ2QY
	xaCytkPpB8HKmRzHIcV8/IKUG+R7SgQkVxAfbXQ20L4Z5JBCbXGaRV0cgfDHfO2ATw
X-Received: by 2002:a05:6a21:1509:b0:366:14b0:4b16 with SMTP id adf61e73a8af0-395c481f45amr4154028637.33.1772231727251;
        Fri, 27 Feb 2026 14:35:27 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c100csm70706155ad.23.2026.02.27.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:26 -0800 (PST)
Received: from jro by jrotkm2 id 1vw6Qf-0003VW-29 ;
	Sat, 28 Feb 2026 07:35:25 +0900
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260227184804.GC3836593@ZenIV>
References: <14544.1772189098@jrotkm2> <20260227152211.GB3836593@ZenIV> <26309.1772206864@jrotkm2> <20260227184804.GC3836593@ZenIV>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13484.1772231725.1@jrotkm2>
Date: Sat, 28 Feb 2026 07:35:25 +0900
Message-ID: <13485.1772231725@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78802-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hooanon05g@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34C721BEBCD
X-Rspamd-Action: no action

Al Viro:
> The last point where LOOKUP_EMPTY (or AT_EMPTY_PATH) matters is (and had
> always been) getname_flags(); pathname resolution proper doesn't care.

Filesystems recieved LOOKUP_EMPTY before v7.0-rc1 and could use it to
detect a case like this.

	fd = open("fileA");
	unlink("fileA");
	name_to_handle_at(fd, "", fh, &mnt_id, AT_EMPTY_PATH);

The flag was used to support
- unlinked but still alive inode
- without its name
and d_revalidate() should handle it still valid.

Yes, the filesystem is out-of-tree.
Now I understand that LOOKUP_EMPTY is not passed to filesystem
intentionally.


Thank you
J. R. Okajima

