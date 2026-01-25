Return-Path: <linux-fsdevel+bounces-75390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHAyHq1sdmmmQgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 20:19:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372B820EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 20:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DD130067BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 19:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373532F3624;
	Sun, 25 Jan 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izcuCUGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A68F4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368740; cv=none; b=Gmknzevt67GYyMCmWgve/qswverdjnSm2j4mgNQER7fOmBGggliyLqcPgPzdrToYreVqLjDSYNz17Ie5DbaWZtRtz5A0pm3VLV1Ftzll1Kt1+3wgsnSfA4ZHwmLaupMBiDKcGCC1MlDQRaIeuPsLdQyHRWat4hOCQLQQT2k7yKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368740; c=relaxed/simple;
	bh=2fmjkzCKOujvwPwn4NDfyFdwq2yVYXAp4mogONgeCBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfUYYKduqQz15KLl40ZFS4WorTaOdC16X+e6kDfqXRhzg+r7Nf4Un0tkWiMQrb4iNfK4g7e4OeJ49zI3RzCQ84ESsPmnUu2/gMRDu+GPYsUQs1yTpH5I2dFjQ8bLQq0ljQ568TrFOTN18PjFi9aLzDHITHxhKZfwm6Z98wH5E3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izcuCUGi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801bc328easo44201585e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769368738; x=1769973538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL3p6PaKPijKcvqNpPtX3cZg2GLs3mUV1zMahLx71cQ=;
        b=izcuCUGiQAJz2XK4odWaUJXfgsTO13CtuBo9icBgL2Q0RiZu3QAep9R54qWsj78Hn9
         sQM6MFgthys2kuOrAW2hroIJX2rPa7I7gdLkEWbRPiRXzCSpPLGZPmvl25WvvzExCd/d
         y6U44NhMuKT2e/pYyXWd9mSm4DSfgYTYPbtz8qCVKi9QxKWUrqt32/EYHQQ1yvpDOUzz
         GVuVby505qLj1g6wg0gUr1cxtlQZ2aeh5PE+0zHVw23QGpbbzJa8HkBSWpNI70woeA7Y
         qn2/9+LSHUGmWpd6GHqy+aUdtr4mFuKKeZg5bJyzjN7yh8MB6Dap24F1kPvZKEkcxX7F
         cSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769368738; x=1769973538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CL3p6PaKPijKcvqNpPtX3cZg2GLs3mUV1zMahLx71cQ=;
        b=ujBE+igPYPzBs7qP/tDJwe8FMOlibQfKFIgw++KVfZRAEr2NTjXbukB+A4jVZULiy7
         yTYuoVOgtOIciwb7PqhaFGL/RXEZe/qKEHFrcp9Sqq0kAYQPYnHLqiltUpsJQKGuw8QG
         Cj5xAspbQtJLbPNpCwVz97fn/jFfE8bK47uYImNDr3o0eO5WU2U8f+UQaldvORfWqevk
         JcZ2R2OPzHh/b/9AZVLA1NCWUdtXPKNxm3MgPldUZJ97a8NEH9LH5hN+uMylptziorDE
         e0yLT24aZlt9kL++MdYmuMqL6RtYUzH0Vl/WYQ6tcoezMb5xmGBvzwrWMOPi2D2sov8J
         1J5w==
X-Forwarded-Encrypted: i=1; AJvYcCUEwECicQu9LpRIXRdrR95R59rCTekEEWkrfKbOfAJvYs3HgUlGf6nL331SHj+6onPn0vLuX93TsSjhkZ1M@vger.kernel.org
X-Gm-Message-State: AOJu0YzqeOj/vtg9PSywU17e5jmV9Pz5LP1HQvcwRtwEVRZCSkql8UMe
	338N/KLR47nZcs1juf1ZjVO5W/1wZZdPOJbVCzqAR2kzD5c8MsWpcJ4g
X-Gm-Gg: AZuq6aLXfTxL6dH81wRI5Bx+0QSoPQe+JF+aD3BUdwXK1K8d+SE8hiS5qJWheapW8fU
	F7QHPPQCaVVZ/Y8KbYQ2G4qapMzBSbe4snIdsEjiMYf7fglXHWIXbXZ7tJ0vGFTLaUG1a5ZV5yd
	/uFJ4dDl+HT/HfcOuq/SQIxQJFLpc/nIlm4DItZIeUCaeQ068V26g8g4YGsEE7wbdw/X7My7bRy
	Hb4JjGRI8GS9iSmlu7c+2Ta8Un/lppol/pDNHTe5rhTxzQRkR+HfTCDTQVZ8syNKcjhm3kqtOXp
	Uc7qJfRMItQ75TMg3CddN1iyoIkqQSwdy7EevgMkhrZB8RmqD6SZEUNSumiZ8pfHBSgegO8D7FA
	vzHotpKellTzYORYogGJliZ3yVOs7hAdDXNWTSP6ZWcegHKoRVdeQwcQ2327OsbvPYNeBy49nJx
	ByAjGeT0k=
X-Received: by 2002:a05:600c:6818:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4805ce5068amr44282105e9.16.1769368737480;
        Sun, 25 Jan 2026 11:18:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4804d3ae17esm86692895e9.0.2026.01.25.11.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 11:18:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Date: Sun, 25 Jan 2026 22:18:49 +0300
Message-ID: <20260125191849.1944886-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75390-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2372B820EA
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> Currently pivot_root() doesn't work on the real rootfs because it
> cannot be unmounted. Userspace has to do a recursive removal of the
> initramfs contents manually before continuing the boot.
> 
> Really all we want from the real rootfs is to serve as the parent mount

Note: this *is* possible to get access to nullfs.

In the end of this email you will find code, which proves this. I tested it
on current vfs.all. The program will print "done", and this will prove my
statement.

I think this is not a bug. I just want to make sure you are aware of this.

=====

#define GNU_SOURCE
#define _GNU_SOURCE

#include <fcntl.h>
#include <sys/mount.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sched.h>
#include <sys/wait.h>

#define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */

/* Get information about namespace. */
#define NS_MNT_GET_INFO _IOR(0xb7, 10, struct mnt_ns_info)

struct mnt_ns_info {
	__u32 size;
	__u32 nr_mounts;
	__u64 mnt_ns_id;
};

int
main (void)
{
    mkdir ("/foo", 0777);
    if (mount ("tmpfsfoo", "/foo", "tmpfs", 0, NULL) == -1)
        {
            fprintf (stderr, "mount\n");
            return 1;
        }
    int ns = open_tree (-EBADFD, "/foo", OPEN_TREE_NAMESPACE);
    if (ns == -1)
        {
            fprintf (stderr, "open_tree failed\n");
            return 1;
        }
    if (fork () == 0)
        {
            if (setns (ns, CLONE_NEWNS) == -1)
                {
                    abort ();
                }
            if (umount2 ("/", MNT_DETACH) == -1) // This umount2 will succeed
                {
                    abort ();
                }
            _exit (0);
        }
    {
        int status;
        if (wait (&status) == -1)
            {
                abort ();
            }
        if (status != 0)
            {
                abort ();
            }
    }
    if (fork () == 0)
        {
            if (setns (ns, CLONE_NEWNS) == -1)
                {
                    abort ();
                }
            if (umount2 ("/", MNT_DETACH) == 0) // This umount2 will fail, because we got to nullfs
                {
                    abort ();
                }
            _exit (0);
        }
    {
        int status;
        if (wait (&status) == -1)
            {
                abort ();
            }
        if (status != 0)
            {
                abort ();
            }
    }
    printf ("done\n");
    return 0;
}

-- 
Askar Safin

