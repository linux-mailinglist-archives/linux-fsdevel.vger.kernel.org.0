Return-Path: <linux-fsdevel+bounces-77816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKihFSKymGntKwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:12:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A716A4BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E773034B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA03365A1C;
	Fri, 20 Feb 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeURJjEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637A21578D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614720; cv=none; b=TxUX7AUgfMyWRwNhrevZoOQk95IkaSiffU6/E+YzMor2NiNeWEobFa+Py+TorcLbeKInQ3hPH6JbFhYw8Vo3cJmIwGt1vltS+xufb386zxgx9NKqM8iosKFhrFakBlA4R2PsBlfMfgomkAV1zQ6Zc7q3CRKqfHIdjw+vWjOyNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614720; c=relaxed/simple;
	bh=M8P+BbQ1YqZa4ng6H3k/8o1frpPX12XdeZj5ECuK2xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EonPwaibYzCA5pzfvFc4xPmDDvF4F86UJ7VU+Yyt5Y6YtKRUgNKL9+UATaJZ9v6IqS+g+jSL8QPeAnL05ht+uWlkwqZYtbACz6qlwvsUm5QjfsguMQwQvU0IyDizjmFG4o6OlHc3IBzhLYEqK+jlvJ90xWmTIErumJI68ZGRIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeURJjEP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-480706554beso27351415e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771614718; x=1772219518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp4Hmr4tnrGJtnxnP1S6eBYh/Nilm6oZrfuoKYFMN2U=;
        b=XeURJjEPAhhsPz8gwaYzwl8B171cOhVK1QrAju+c45qH0I/E7RF3hSgmwVhCgw/g7R
         umW/c8CcInLV7DGnspPCOzaZh8IlctKLK3xx/VR+79sYJnswdy6HNXQUdbreUWw9kYzA
         YsgRq/9UvZWYPx7n2DodWrNIDXDUUVrjU9Q7xnNPy6vzdjiiQP5jIEl00rO+sLebmlum
         FmYrYuWL6Ia/4QWgk2+woZvH2hLL62go09TzukFizZbP/46i1WigYjU+7KI0zSriFcwx
         wGwy0CTwl8bYLKZYNWzNOdm76rNcL2IHp9IAYOwMh8lc+NqpgU/BllAuYibUnsTebnwx
         wwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614718; x=1772219518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zp4Hmr4tnrGJtnxnP1S6eBYh/Nilm6oZrfuoKYFMN2U=;
        b=pANXmLXc56vVDLMhZQ08+4IMIRQ9Bc9Pfr+BFn8k/5GBUtiv1c73aU7HCEYBpWrG97
         Zl1AKvhtrq4WCKZ7BbxStOTOIl/28fR/Mp7bgynGi/j8VztaDmJpEejlC4wS1+qzU38s
         uLBRn+/F2qD/oZb65oW3K0Lm5l9MVa7xzgU1v2sFuW+cxHWFE3mMRzyCghJW+ls6TmTf
         m7Ya/waLFYyxncX7UnjH4QFz7cv+oklacC2MlSzJooc5P8dnHMMFt2SeYVU57d6OOE8/
         5tXxREtwaiZAxgZtaMTVy1pyqtIOhvx3LkCm8e7Ky/fSTojcJU1wmBwVjokyIPoUvSqc
         bLBA==
X-Forwarded-Encrypted: i=1; AJvYcCXWsNTg1EFF2D2yVN3coYToCNjuydBbIrQpqOWWxV1H7U+9IOpqqorzOX/+3pTgrvXZ/o+LBDYE1HF3vMgE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zj3Ns0g/6cJn8tbRBcfCgBqIA1E373bqFEyY+DGavB5wDNv/
	4+1C+tQVDjQKaPa0mKjS4OHzHgPX8Qjk6N5TQZ6dM+PVTp7N3huPiONVzK9UVA==
X-Gm-Gg: AZuq6aIIpamjnz8Rw3oHkLg8/qk+AUsAyz1xtY7CJcOk2942KyBwUpjqRmrHTKP0uC+
	QNpCr4lAyVlg2a6tuZ6RgrTmnnz8hiXCIRGeWCBojueQhVJ8RwTUO4GR9BI46IDolADSGQ7Aclb
	t/+tHM4237kUq/NKpOQZtz//vMginUr/fIowZCHqW+FnE1CL63TAt8ucccS8feIUrjeLErSygAN
	w2eDV0KZ2xgqGR9VmgNE3B3cIWwpTb75fca/pe9ddLiwcxnHUTVuJ9Cos+2CmtEDz2hOuGhKHyo
	ZU9W9VBt/SxbXeucAlWKqE8UaB80smkVNujUAPX6zL1nRznxk9a4zW4kpKSe3+5uWJklKCySEOp
	LzL4rlaLTqGjcA+VoJZNisnwdyA3zNHbmSPYlvtNCOSudNLECij+onXzW5cwADzZZHvsJm/C9sQ
	bgLlrTL6B88EqP08BmF3hTnw5zvmnJzw==
X-Received: by 2002:a05:600c:3516:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-483a9637590mr8799125e9.26.1771614717583;
        Fri, 20 Feb 2026 11:11:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a9b21ceasm3704985e9.0.2026.02.20.11.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 11:11:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: ddiss@suse.de
Cc: brauner@kernel.org,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	rob@landley.net,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always available in initramfs
Date: Fri, 20 Feb 2026 22:11:50 +0300
Message-ID: <20260220191150.244006-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220105913.4b62e124.ddiss@suse.de>
References: <20260220105913.4b62e124.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77816-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: EC4A716A4BF
X-Rspamd-Action: no action

David Disseldorp <ddiss@suse.de>:
> I'd prefer not to go down this path:
> - I think it's reasonable to expect that users who override the default
>   internal initramfs know what they're doing WRT /dev/console creation.
> - initramfs can be made up of concatenated cpio archives, so tools which
>   insist on using GNU cpio and run into mknod EPERM issues could append
>   the nodes via gen_init_cpio, while continuing to use GNU cpio for
>   everything else.

This cannot be done in proper way.

Let's assume we want to build *builtin* initramfs using GNU cpio and
then concatenate to it an archive made by gen_init_cpio.

Then we want CONFIG_INITRAMFS_SOURCE to accept already existing cpio
archive AND file in gen_init_cpio format. But, according to
CONFIG_INITRAMFS_SOURCE docs in usr/Kconfig, this is not possible
(I didn't check whether this is true, I just have read the docs.)

This means that we should do this:

1. Generate an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive
2. Create kernel config, while specifying resulting archive in
CONFIG_INITRAMFS_SOURCE
3. Build the kernel

Unfortunately, this will not work, because to invoke gen_init_cpio you
should build it first. And you cannot build it if there is no config
(I checked this).

So, we should do this:

1. Create kernel config, while specifying an archive in
CONFIG_INITRAMFS_SOURCE, which *DOES NOT EXISTS YET*
2. Build gen_init_cpio by invoking "make usr/gen_init_cpio"
3. Create an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive. Put resulting archive to the path specified in
CONFIG_INITRAMFS_SOURCE
4. Build the kernel

Unfortunately, this will not work, either, because command
"make usr/gen_init_cpio" doesn't work in clean kernel tree even if
config exists (I checked this).

This means that the only remaining way is this:

1. Create *fake* kernel config
2. Build whole kernel (!!!)
3. Create an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive
4. Create config, this time for real. Specify archive created in previous
step as CONFIG_INITRAMFS_SOURCE
5. Build the kernel, this time for real

I hope you agree that this is totally insane.

So, there is no proper way to create builtin initramfs by concatenating
archives created by GNU cpio and gen_init_cpio.

I think this is a bug in kbuild, and it probably needs to be fixed.

But I think that my patchset is a better approach. My patchset simply
ensures that /dev/console and /dev/null are always available, no matter
what. And thus my patchset side steps the whole issue.

Here are additional arguments in favor of my patchset.

* The kernel itself relies on presence of /dev/console in console_on_rootfs.
There is even comment there that currently says that opening of /dev/console
should never fail. (The comment is wrong, and this patchset fixes it.) So, if you
happen to supply builtin initramfs without /dev/console, then you will
build kernel, which violates its own assumptions. This will not be
detected until we actually try to boot the kernel. And even then it will
be hard to understand what exactly went wrong.

Why should we allow this failure mode? Let's instead ensure that this will
never happen. I. e. let's make sure that the kernel's asssumptions are always
true!

* My patchset makes the kernel not more complex, but more simple!
(28 insertions(+), 33 deletions(-).) Moreover, my patchset makes it
simpler not only in LoC sense, but in conceptual sense, too!
Currently codes in usr/default_cpio_list and init/noinitramfs.c are
very similar. It is possible that they will be out of sync in
some point of future.

By the way, noticing that they are out of sync is *very* hard. Consider
this scenario: usr/default_cpio_list contains this line:

nod /dev/null 0666 0 0 c 1 3

and init/noinitramfs.c contains this line:

init_mknod("/dev/null", S_IFCHR | 0666,
                        new_encode_dev(MKDEV(1, 3)));

Are these lines equivalent? You may think they are, but they are not.

init_mknod function above in fact creates node with different rights
due to umask of kernel thread. (And thus unprivileged users will be unable
to write to /dev/null...)

My patchset merges both codes into a single helper, thus making sure they
will never be out of sync. And thus my patchset reduces complexity of
the kernel.

* Currently it is okay not to put /dev/console to external initramfs.
But it is not okay not to put it to builtin initramfs. Why creating
builtin initramfs is harder than creating external initramfs? Why we make
lifes of developers in one of these cases harder without any reason?

Consider this scenario: somebody built kernel and external initramfs.
Everything works. Now they make this initramfs to be builtin.
Of course, they expect that everything will continue to work as before.
But it doesn't work. PID 1 doesn't print anything to console,
and you cannot even debug this, because it doesn't print anything to
console and you cannot see your debug printfs!

This clearly violates principle of least surprise.

-- 
Askar Safin

