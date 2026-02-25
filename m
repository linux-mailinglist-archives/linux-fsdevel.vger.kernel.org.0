Return-Path: <linux-fsdevel+bounces-78397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCbgL8Zgn2lRagQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:51:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2F19D738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60A93033A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717F2D7DEA;
	Wed, 25 Feb 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHtKz67z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kvhL/yFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388821B192
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052670; cv=none; b=j+qPays9dmF9VO2BhAclm6Tetg6R/1/4VNHoYWptPAygGWinBLckBJ9AeTw0E5NOlYjmU3kGbRJgU9f/a5VvJntrlqlkJzW/a9s02ZXR9GTamaC6LgqcCfYT9aYTENkyyHCSxXK+sonl5xZF5GSH7/a/JILR+kRGLVAUzr+M+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052670; c=relaxed/simple;
	bh=nm6u0+hr479dzNgZcMkVwuZnh/UT0qw3i2dqBIe6OCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KouyENBrkHOOPdGSmh7jqCrNh0JXxyeT6hK7QvPJMV6FJy+gD/qUwPTQrhx5RnOPy6wDRK1KAo6ZwX15boKmHvADOQn/l4M0mzpXWhPyh+Qsb7lbya/GvBgWlBjuitHt6MnlLv+m9898/kc9zM3u+UBq/vD9HxDZt2TTBBR82mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHtKz67z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kvhL/yFo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772052668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5r33UzKOJc+MIYpqZGZK3GSLjn77CaFhqkCdFvDTxFk=;
	b=iHtKz67zhlgX4oFcFGSQgTUVCe+GIy5yqu9O3md2UnHhODmWLWCJnswMG4bN9ughyJB1uU
	0jmGdKPNMlHq4bJIjW31GV+dVWjCNyRCHTcwYqEsb9CazD27B5qFn4tYUublWqZJuho3q7
	uOyBhHaSg5XfHx5tmYPiYx2OKISqXFg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-uX7oEB0LMtqUxj0xLTRZVw-1; Wed, 25 Feb 2026 15:51:07 -0500
X-MC-Unique: uX7oEB0LMtqUxj0xLTRZVw-1
X-Mimecast-MFC-AGG-ID: uX7oEB0LMtqUxj0xLTRZVw_1772052666
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d496d080d8so561041a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772052666; x=1772657466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5r33UzKOJc+MIYpqZGZK3GSLjn77CaFhqkCdFvDTxFk=;
        b=kvhL/yFojGXkRjhE59lj81qJc2SvBmcsPVeiaZeMlR5BeYsHs7qY2OZBZH029yFOLJ
         cf0YqL+Gfu5gXIvmeSa/IVCSosUFy8dpmZhpZ7OMFKxg1gcLExAcvOjWdj/74BXIyUEW
         cRchdBh3hWyEM9lFV8pRSGvkZBGpYOvZ7d24kOYfvyXsR8yJYJrn01vMc/GiOszTWTr4
         AIAKxmKKiE4MGBxps3e7OdsbL419Si4t3YLQNlqujPKMa1bbXgAmVR4REl6mvsGf+DRz
         u/NGhqt9UAzy3WnOmfhbkaxLySfojTy0hNv49LtsZAMjbqNpxNI6HcLFVishhNm9z6rS
         1JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052666; x=1772657466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5r33UzKOJc+MIYpqZGZK3GSLjn77CaFhqkCdFvDTxFk=;
        b=ZU785vwIiJKrGbuRkxDQ04dZPJKD/klCKuGHt4DDLSChW5CXxjqhOppX4CZ6k+s/50
         CustRZl5/YOUlENRQNWB+EIPxu3BjDCbMZ21ayd9Ye9Cv8mUCUwA8ufNUdfQsma8xXm4
         IpY1ebXllZWETOF9RHUqhPE0Yac5Zck3RmpsbYhN0QuxgNG+s8VIAyUtqDDLI2FjS3r3
         Zx2EQ5AdFl84YAqGyqjwMrHX8tSbRkaywn/i8mrYtaLkTvRhnRFvKs5U2XcTdd43co73
         c6ZoeF6tqLOeJDwHBXP/ZkeWpwfaFKDh/4QZt3D9deE9aRwwJh7uyJQmigNwa7kNR47B
         p5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUH50GMinDyPbM9NdwxWphdm53eajT0QSK3OALO3M7Ess86nfizGjK946y3SIhM8/raaGhOAgXxzl3Auld3@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGpmvOMkBsmfx0EBw8LaQeATonuyxz1YmfrGND8PCz/jh6C0m
	fPC7n+tmzVlfBsvTpxDBwI+f6wk2SPaz8LbRHq3HvPUKjzjNNjXerSC1+dASm14DlnU1wBpOwP1
	0WyoH/VPuw8RLlXPq8qPW415QjftmTzG37O+jME235KQlWAwSLOjH37vXbqonxrmRPd2PsvLP9z
	Q=
X-Gm-Gg: ATEYQzxiOBi63uhzY+RF6wj8hTJ0i0GX76pismIBWwjk/SwxyaYBc1Egp/2hKG8jji9
	4tgup+0IYJ6n/uDPJFsuqVC8tWvPehupHHGLpUYMj7p6V2Ol6nC88QAkvTJnuh8AX7rVVjM6GlX
	IjmfCVSiY2jLjdS54R4ZSqGv6c/jy5PsOkpJPxYXUDgZtqIANmJSXSbxry4bL8utPlMVkI8N5Jm
	bW8kKnbQMkKPCcFVivGepQeeZYyLuBNaCYta3mV/P5WQ5PM7XSVGoeI19uGSIEGUV1SjYUjrKbF
	KhOXqVx+uxu+oPwVwzgmtwy/n6qvsH6Eu4XpsFeStqhnIzPIJ6bqMn2/JYVbG4i9f7sLpGuTT1d
	4SvlwuU4ngu37yLcCK8jNlT8/Sg2SCDQ7Gar2HpsBPgU/XEf+s2xV
X-Received: by 2002:a05:6830:4902:b0:7c7:62bd:7fac with SMTP id 46e09a7af769-7d52c217445mr11413496a34.9.1772052665827;
        Wed, 25 Feb 2026 12:51:05 -0800 (PST)
X-Received: by 2002:a05:6830:4902:b0:7c7:62bd:7fac with SMTP id 46e09a7af769-7d52c217445mr11413484a34.9.1772052665412;
        Wed, 25 Feb 2026 12:51:05 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586226d14sm75928a34.0.2026.02.25.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:51:04 -0800 (PST)
Message-ID: <c64f9d66a10d151e3725336d2980f56ca5aff5a4.camel@redhat.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 0/4] ceph: manual client session reset
 via debugfs
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Wed, 25 Feb 2026 12:51:04 -0800
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-78397-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22D2F19D738
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> In production CephFS deployments we regularly encounter situations
> where MDS sessions become stuck or hung, requiring a full unmount/
> remount cycle to recover.  This is disruptive for workloads that
> cannot tolerate the downtime or the loss of cached state that comes
> with unmounting.
>=20
> This series adds a mechanism to manually trigger MDS session
> reconnection from the client side without unmounting, exposed via
> debugfs:
>=20
>   echo "reason text" > /sys/kernel/debug/ceph/<fsid>/reset/trigger

What do you mean by "reason text"? Usually, it should be some command. Do y=
ou
mean that any string will trigger the reset? Is it good approach? What if a=
 user
sends something by mistake or any malicious garbage? Potentially, it could =
be
security breach.

>   cat /sys/kernel/debug/ceph/<fsid>/reset/status

This "reset/status" sounds slightly ambiguous. Is it status of reset proces=
s? If
we didn't request the reset, then what this status means?

>=20
> The reset lifecycle:
>   1. Operator writes to the trigger file
>   2. A work item collects all active sessions and initiates
>      reconnection on each (via send_mds_reconnect with from_reset=3Dtrue)
>   3. New metadata requests and lock acquisitions are blocked until
>      the reset completes (120s timeout)
>   4. Session completions are tracked via a per-session generation
>      counter to handle stale completions from timed-out prior resets
>   5. Lock reclamation is always attempted during reset-initiated
>      reconnects, regardless of prior CEPH_I_ERROR_FILELOCK state
>=20
> Patch breakdown:
>   1. Convert CEPH_I_* flags to named bit positions so test_bit/
>      set_bit/clear_bit can be used in reconnect paths
>   2. Make wait_caps_flush() bounded with periodic diagnostic dumps
>      to aid debugging hung flush scenarios (independent improvement
>      that surfaced during development)
>   3. The core reset implementation: debugfs interface, reset work
>      function, request/lock blocking, tracepoints, and session
>      reconnect completion tracking
>   4. Rework mds_peer_reset() to properly handle all session states
>      and integrate with the reset completion tracking
>=20
> Open questions / areas for review:
>   - Is debugfs the right interface, or should this be a mount option
>     / sysfs attribute / netlink command?

Recently, I had short discussion with Greg Kroah-Hartman. He was completely
against of using sysfs for transferring commands from user-space to kernel-
space. So, we could have troubles of using sysfs for this. And
/sys/kernel/debug/ sounds like completely wrong place. Because, this is not
debug feature or option. You are suggesting this as a regular feature for
production.

Maybe, we can consider eBPF here?

>   - The request gating in ceph_mdsc_submit_request() is best-effort
>     (no lock serialization) to avoid penalizing the normal path.
>     Is this acceptable?

So, we have "MDS sessions become stuck or hung" and we are trying to submit
another request. Is it sane enough? We already have a dead session. :)

>   - Should the 60s reconnect timeout and 120s blocked-request timeout
>     be configurable (e.g. via mount options)?

I think we already have some timeout option in the mount options. Are you
suggesting yet another one?

>   - mds_peer_reset() rework (patch 4) is substantial -- would
>     reviewers prefer it split further?

Do you mean patch 3 or 4? Because, patch 3 is huge in size.

Thanks,
Slava.

>=20
>=20
> Alex Markuze (4):
>   ceph: convert inode flags to named bit positions
>   ceph: add bounded timeout and diagnostics to wait_caps_flush()
>   ceph: implement manual client session reset via debugfs
>   ceph: rework mds_peer_reset() for robust session recovery
>=20
>  fs/ceph/caps.c              |   7 +
>  fs/ceph/debugfs.c           | 171 ++++++++++-
>  fs/ceph/locks.c             |  24 +-
>  fs/ceph/mds_client.c        | 577 ++++++++++++++++++++++++++++++++++--
>  fs/ceph/mds_client.h        |  33 +++
>  fs/ceph/super.h             |  60 ++--
>  include/trace/events/ceph.h |  60 ++++
>  7 files changed, 879 insertions(+), 53 deletions(-)


