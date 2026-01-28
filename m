Return-Path: <linux-fsdevel+bounces-75727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCcIGgoiemmv2wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:49:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE5BA3286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66D693007B39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE343502AB;
	Wed, 28 Jan 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="AjrzvFwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A029827E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611764; cv=none; b=DF+4xZTvAsqGSyR08LkeI6RXxRSL4vtAH0ZyOj0WhU6w2skAYJC+OBR5ON20snqBre4Mo/ged0oArMNej3UWoVd0u96bL0ERMN2QQ6fHt8GDFThI8958aINFdmOLOP+abfl8Bas3aA9we9sj6ayH0a7kbZNiiVAjj4Utz22Xw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611764; c=relaxed/simple;
	bh=IkJWJMJLpcyV9VSmZouqP4mDwwtFFzlba0fucljUEpk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version; b=sWjZPSAhGDZYZLI/IjV2xP7ES1LtEhKLAfpmKice+/P7ZAzxo6CSws4TE6GVdga0wEFKvMTsp5pL557MT79erlkjW0mVnFjaE9kBe6IC9rCdyMCWCpz7r//QEyJopA3VSQk2koZw9Du9lIG84PfxumATHXS7V7CnP/AKlBc21Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=AjrzvFwc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B1F33F887
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769611760;
	bh=XraBybXD5tsGtLLp8ozxwcFptvRhogq8Wf8sKZhViPA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version;
	b=AjrzvFwcPNdEtDOjeAxeQoGdATwaEuFvCAVEQ8HLJdUjXMKVIYXWuzhL/huTk1+Nd
	 Pg3XaxYBH67nRBb3xN6G9yQIg7BRWSDyaSibMk5P1biBZo44SNDk9dKF6dYeaN9nuD
	 tSV5g6zCrf1fMcZx1FBnqC7nPyNncynfvAyTTSIXvtUEtgtqlqsnAtSUbSGutXWBNv
	 XPKpTb538UIimIMXUENWii7qsq4S+LKx3qeVZo8J/oMV5uefPcIainwyfIqNA4DxPt
	 +kPqB7tBKvGu/i162l5O1bgEBVr29mS/gwwapEqOd6xgpaLaStEMO5IqjRAObdEpRF
	 JIzMv9FdGxsdzYbpbUOmzrdAf1RKQmLYjKPMNcUfohgw9w+bMMzy0n57CFF0QqfwiU
	 xXKb16N9AQhK8nopciFygo26i+ACdm0pbNWxJOOpI0Drg2Jksut5ZLRvJUfGV52zW4
	 zPkutFs0+ugkRjLDBTq39caXlTPQKbIRRt5t95qbvJqaCaA9mkL9sR87K2rGtoVMKm
	 UwC1sm9kQsExumrLi5XY9y+1lKpmA9bKvwvQQKLPcU9+8bdY7TjU1vEawx6eI8MxS4
	 oecwfC49BAAP4GB0+W8FOTXu6TuG+l4gGmvNeCrOl7I2fjZSy2jIuvS+TGlLrPtVoJ
	 hyJdCzIGJ5/Vz+3xSJqd1xbc=
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d18e9ab16fso2133635a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 06:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769611759; x=1770216559;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XraBybXD5tsGtLLp8ozxwcFptvRhogq8Wf8sKZhViPA=;
        b=i9cD0I80KLf3KT41fZmXokHzStzHJ94R2A9ASJjVLNzQHgQ0lYhEi9cBgltTKvL6Dw
         tt9zX2oZ+Yc8Pi2wf+b8k7CQLEZKJwbaPCDkEIMjGZ8M/XJ3ppd3GyY48dhf1dJ19qQG
         RiSweMC9l2gVKE4VN2exFkSVZTGwCkvz5C1xhvgByWiNVTwP/zNEUROPbNhKCQIJQv7/
         IF0eqyeOOgdBacnC4/XIv/Y+BBb7+930mA948iQB3fTO24VuGZB2ECwUVhblZ9mrb9H9
         PO4+vQTyOvCCXLMugHRDqF9fL3cTI6XG+lSE1VXNYA2TOuYoID0tYyDivSULVJiid/54
         nr4w==
X-Gm-Message-State: AOJu0Yze3ioQRj3q5+W3age7n+0WPQiWkVP5U+xUCuqvW/1BMBvnuPrs
	rGi67cVTUzViW6Wod1cy9r7pMRBcFWMseYBls80dp/3iNInDuyjFPSemMe3L5IQmYONmaWu63hD
	kohPSnTl7VtOgMzVLhKSCKSlQ9oqkCUvvk3QEA7izF1ImgPNQGMqpIzpozRgLQnpqFe9OwXRVWs
	B5YPT/Lfw=
X-Gm-Gg: AZuq6aJXuBkcW/P6BYZX61kPQePoPubGewB3Zv3KnjT/Pm+5chp1LMh2xm2FX/d6H/u
	FXYwZp23fByJ/9nJpmhp+Cp/T9LsgPp8fR533bIuzoXtHvFD5+lrz8fFYgxQcEVcR058t4YKoAe
	NDn4MlZW34s96Z0iqjgwkXqq1lnDNH21T89JlfFxaQtZ9Zp192GgVefY2GlUne6sr5PwlC+YHJT
	ZR6sn48k0yI3O+Nmp0PzhRruX8EuNjGxZzqciT+Y1jFWvAxeiekYz5z/QyS/QaQpv1rJ8npIpK8
	n30WGDsWSDjaUix1bctxENFgkeC38dT+CONSbh22cfzpkxy/vg4pDbl5EyYAFHGf/1BbhLuA+1H
	mzEvhFApTAHOC8yBsP2p6
X-Received: by 2002:a05:6820:458d:b0:662:5684:d108 with SMTP id 006d021491bc7-662f2041140mr2631116eaf.20.1769611759348;
        Wed, 28 Jan 2026 06:49:19 -0800 (PST)
X-Received: by 2002:a05:6820:458d:b0:662:5684:d108 with SMTP id 006d021491bc7-662f2041140mr2631037eaf.20.1769611754179;
        Wed, 28 Jan 2026 06:49:14 -0800 (PST)
Received: from localhost ([2601:444:703:15b0:cfc8:ccb2:2ef8:893a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f99447b5sm1483115eaf.2.2026.01.28.06.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:49:13 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 08:49:12 -0600
Message-Id: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
From: "Zachary M. Raines" <zachary.raines@canonical.com>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.20.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75727-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zachary.raines@canonical.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:mid,canonical.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DE5BA3286
X-Rspamd-Action: no action

Greetings,

When mounting and unmounting many filesystems, /proc/<pid>/mountinfo someti=
mes
contains entries which are duplicated many times.

Summary
=3D=3D=3D=3D=3D=3D=3D

Sometimes on a system that is mounting and unmounting filesystems frequentl=
y,
for example running lots of docker containers, the size of /proc/1/mountinf=
o,
can become very large -- 100s, to 1000s of entries or more -- with the vast
majority being a single entry duplicated many times.

This causes other problems on the system, due to systemd parsing the mount =
table
whenever it changes, and eating up a lot of memory, for example [1]. Waitin=
g
long enough there are rare events where the length of mountinfo can go into=
 the
millions of lines and lead to OOM and kernel panics.

Running the reproducers below, I pretty reliably see an Ubuntu virtual mach=
ine
kernel panic due to lack of memory within about 24hrs.

Versions
=3D=3D=3D=3D=3D=3D=3D=3D

Bisecting the kernel git history, I was able to track the issue back to
'2eea9ce4310d8 mounts: keep list of mounts in an rbtree' [2].

I've tested on 6.19-rc7 in a virtual machine and the issue is still present
there. /proc/version:

Linux version 6.19.0-rc7+ (ubuntu@kernel-builder) (gcc (Ubuntu 15.2.0-4ubun=
tu4)
15.2.0, GNU ld (GNU Binutils for Ubuntu) 2.45) #8 SMP PREEMPT_DYNAMIC Tue J=
an 27
22:33:35 UTC 2026

running on Ubuntu 25.10

Reproducer
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The problem can be reproduced by mounting and then unmounting tmpfs in a lo=
op
and in a seperate process reading /proc/1/mountinfo and checking for duplic=
ates.

I used the following scripts:

1. Mounts and unmounts tmpfs

#!/bin/bash
counter=3D0
while true; do
    unique_name=3D"tmpfs_$$_$counter"
   	mkdir -p "/tmp/$unique_name"
   	sudo mount -t tmpfs "$unique_name" "/tmp/$unique_name"
   	sudo umount "/tmp/$unique_name"
   	rmdir "/tmp/$unique_name"
   	((counter++))
   	sleep 0.1
done

2. Reads `/prod/1/mountinfo` and checks for duplicates

#!/bin/bash
THRESHOLD=3D75
echo "Starting monitoring at $(date)"
while true; do
    # Get mountinfo entries and count total
    mountinfo=3D"$(cat /proc/1/mountinfo)"
    mountinfo_count=3D$(echo "$mountinfo" | wc -l)

    if ((mountinfo_count > THRESHOLD)); then
        echo "$(date): Mount count ($mountinfo_count) exceeds threshold ($T=
HRESHOLD)"

        # Find and log duplicate mount points with their counts
        duplicates=3D$(echo "$mountinfo" | sort | uniq -cd)

        if [[ -n "$duplicates" ]]; then
            echo "Duplicate mounts :"
            echo "$duplicates"
        fi
        echo "=3D=3D=3D=3D=3D"
        echo "$mountinfo"
        echo "---"
    fi

    sleep 0.1
done

Typically, within 5-10 minutes duplicates can be observed, often including
hundreds or thousands of copies of the same mount point -- although the num=
ber
can rarely spike to much higher values. Given a long enough uptime, I've
observed up to 1.4 million duplicates at a time.

The duplication in mountinfo is very intermittent. `cat /proc/1/mountinfo` =
100ms
later shows no duplication.

Additional diagnostics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

While running the script (2.) above, I also ran the following bpftrace scri=
pt

3. Trace vfs_mounts as by `cat /proc/1/mountinfo`

#!/usr/bin/env bpftrace

fentry:show_mountinfo / comm =3D=3D "cat"/ {
    @mnts[args->mnt] =3D count();
}

tracepoint:sched:sched_process_exit / comm =3D=3D "cat"/ {
    for ($mnt : @mnts) {
        if ($mnt.1 > 1) {
            printf("Duplicate mount %p\n", $mnt.0);
            @dups[$mnt.0] =3D $mnt.1;
        }
    }
    clear(@mnts);
}

and observed that a single mount struct was reached multiple times -- perha=
ps
unsurprisingly exactly the same number as there were duplicates detected by
the above script.

Typical outputs of script (2.) and the bpftrace script above are

Starting monitoring at Tue Jan 27 20:48:13 UTC 2026
Tue Jan 27 20:50:43 UTC 2026: Mount count (696) exceeds threshold (75)
Duplicate mounts :
  /proc/sys/fs/binfmt_misc: 2 occurrences
  /tmp/tmpfs_856614_41491: 666 occurrences

and

@dups[0xffff88e5fb9f10a0]: 666

Best,
Zachary Raines

[1]: https://github.com/systemd/systemd/issues/37939
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D2eea9ce4310d8c0f8ef1dbe7b0e7d9219ff02b97

