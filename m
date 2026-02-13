Return-Path: <linux-fsdevel+bounces-77155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKZnE81gj2nNQgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:35:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D7138AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3DDC306C7F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B914286409;
	Fri, 13 Feb 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMIDIoUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C626E711
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004076; cv=none; b=SmV8mUMfY2zxYMAQeIu0Bnf7TXab4e4q9zwSEZM2yVmVaLnpHLff8cHw8YC+m2UpoR+ANrS/WnVcRYSE3OAma37cne04Ous9ECLK0dOjMLX3RwSuf4T2mvoaazWw11SfeTOfbbdNmc2UlasNk6Eqr6pMtxATiuAVgtnUKn7TAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004076; c=relaxed/simple;
	bh=DBdDo5T6oY5wdQ4MPt5mdpH9VpGNwEpBJcCIvQ2o5uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHY8et33McEAZa9mXHS82EPZmc1+zn8TIxHDRhYIfmL3RyBje0jZEHzgCgJ3gswVn4TRbVA/J9lVaXpwi09exlfdaS/kYDE8f2YdHZzJqnun9WE7Rdx9Y+l6teawxeYmVSaLOPrrcqPRJdqbow8YbyVH/8o3MCgv6K/lZ6vPRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMIDIoUF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371bb515eso10706665e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771004073; x=1771608873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87wFJYo0VOtWoZ/jMYhCWlrjmZln/kfauZ/BkQwIL7I=;
        b=PMIDIoUFjFji/w/nf6SGAj3bG1Vk2UjnjZ0M5hfJ/eJ+Vtw5l+S7OfMnMHvEdCrrdd
         d9xU8kJgYfukhX8NCAZ7smxHIcpR/noYzGUDtKbxBEElv4nVfC1W/RNyokUFPtGxzHYJ
         V30OQDF7Pzs8OJvdlVh8H5URm7/s5AeoHjDb/D5GNqdtvIr7yySYWWr/CcwBupuZHlMZ
         /praN/sNTfhteykwDMl3NjutsswLzXkO4RgNN/i3dLyQCGo5SMH5Ld9XFfBpC7YOsx82
         t45JghngnRIzW4IBAeUrAxMybQ3CWH11iekJNCc2IPq4iW0YULF5RLSegsF7Lp5saeSM
         0uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004073; x=1771608873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87wFJYo0VOtWoZ/jMYhCWlrjmZln/kfauZ/BkQwIL7I=;
        b=eYVy4EwFWb6ZTLC7dHcJLdsrKHSTBDZzqkbJyK6Vyk6qys26qKDI2a0YXgtna2lhD8
         VmV1J1v+r4/HP1mOLuCMKyQ4l1ZI5Pd7mlMNuglOHnUqCsV9r2j0y03nxUBCl9fAUsYg
         qkQEbqQMInKo61bAi49FL1wcUHUm3DynR/EoEz6BLk60LvgMTnJSkTjyWGhQLBpIoryl
         Eq5b5SimqZ4JUJu4r6SGFSjVriaWptDJPUDoh8xRBRgW8a70TvObSRsYzWxESGnPvKiJ
         DtJF6z/E+n4a75l40CYs8CauBkeN8mecm+/YCjZrwfiPjNdVO57eSuvW+AhyxujpIJBp
         Kxrg==
X-Forwarded-Encrypted: i=1; AJvYcCWpl8u19SEGONmJQmg3gI81tPUCfL4YJfFA2/dFDju2iMNR1Y3DQsb2nQ8GsuNEUsQiKxuSk4aGb9uRHXnc@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRcjewbDK++nSYklRVkSrDxu211BgnWMcsAxW1GoPLHP0HEOM
	HTcFWeIte9ndOMrRFBcFhOBCNC4EAAKcAxPhAUx2UvueCypCdsU6j5DU
X-Gm-Gg: AZuq6aJWPr90E5yhYvfLJCaQ6lCTq+U86ExxPLP4A1Nhevpd6GLcFRV0aJ6yNMiDmKV
	z0JohSiNRR+vFbboYrprLaU271GsVS7NLozXxAhF+EMPvDVIXlFGNaHPEnjObgeIVdVMalZg+/S
	KEshoTHOnY2t4x1kWQGanM+kWLyW6Co9rkBHRMwKx94KutO9+9Z5V47mvIBsPBWuO63ug2kp333
	TahFmhscLn7FRy3n3PggMuNFCFihz4T66nAtI59mrVEJDZj4C04IMxtfhZrKDr6ycn+fDjUn091
	0uROdgxIkrtkdj02v7rlO+x8IrSqL2qiUJb+nUX81QPbiQNGQ4+VKbeF72q1qb7yQRuzomgY26F
	AcLDsdi4VIcZvxm9VUwVcaGOrKDGTARTanPIucF8tPXWrCv2PCkCBeHK5VrCXH+we453izW1nDm
	h9pnQ8s0pH8SySH91J/94=
X-Received: by 2002:a05:600c:3496:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-48373a5ba90mr44035155e9.17.1771004072757;
        Fri, 13 Feb 2026 09:34:32 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4836ff00332sm72631395e9.2.2026.02.13.09.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 09:34:32 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: christian@brauner.io,
	hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	werner@almesberger.net,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] pivot_root(2) races
Date: Fri, 13 Feb 2026 20:34:27 +0300
Message-ID: <20260213173427.112803-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212192254.GO3183987@ZenIV>
References: <20260212192254.GO3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77155-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A44D7138AE5
X-Rspamd-Action: no action

Al Viro <viro@zeniv.linux.org.uk>:
> We could restrict the set of those who could be flipped, but I doubt
> that "could ptrace" is workable - that would exclude all kernel threads,
> and that could easily break existing setups in hard-to-recover ways.

No. Kernel threads share cwd and root with init, because we create PID 1
with CLONE_FS:

https://elixir.bootlin.com/linux/v6.19-rc5/source/init/main.c#L722

Brauner already said this earlier in this thread:
> I think even for the case where init pivot's root from the initramfs
> the pivot_root() system call isn't really needed anymore because iirc
> CLONE_FS guarantees that any change to its root and pwd is visible in
> kernel threads

Currently classic initrd is not used, and nullfs is not yet mainstream,
so all distros switch to new root during initialization of system using
"mount --move". And this works perfectly thanks to mentioned CLONE_FS.

-- 
Askar Safin

