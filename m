Return-Path: <linux-fsdevel+bounces-78302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKGUBo38nWmeSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:31:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3418C17E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CA5306C7EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D52989B0;
	Tue, 24 Feb 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BBVezdOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B238264A9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961480; cv=none; b=UoHEUXMUr0tI1s6ZBJCdxM4pG7WNr44/bAxCcaHVeE4bWYE2N1ZOKpGIjgGGwBizR9Gi39lGf67W134oBrrPotftWLS13ka2QWkdjRTS4SmrnjAVhjIiP0c9wTqJXv0vQfaPwQryNfZRwPM/63s5Fo1blpAOK1j5RK9jbHbMFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961480; c=relaxed/simple;
	bh=l3fKH2Lg7U2V+94owGDOYblXvSmIcRX8LuWi/lZfpL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLBlpJb3dx7mjvLmDh27hVegFHSjisNSRkoqDJp+YaEPky3uZdQvUtM7G4yBUCSpOdeh02y9TWwZRKjQNFqXQkfOhFq7Z6je540eGt/Ql9KvU+1qfjU4wtGCkk86nBQKS5UgWex85JCNws4TsqqxY2tgXd8ODbbmWZiqqzUokL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BBVezdOV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so971446566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771961476; x=1772566276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CEZDHj2to1OcbNKf2nC3SkdLtqd7DJO13tKCMalBiJc=;
        b=BBVezdOVvdxZPc7vrncqjc7mfAbEeFbHUmLE9ABuBRJ4xOQEyPwRPuCxQi4SJxgWbp
         vD0Ys7qqagIcDSvSm22Ilz+RBVskS0FRSGjjBiZIWqyeIRMasVxNOWpWdbySTT7aBgAS
         hzfRNjn2FlMT5pUgabjvtaDlM5QQuRItSR5mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961476; x=1772566276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZDHj2to1OcbNKf2nC3SkdLtqd7DJO13tKCMalBiJc=;
        b=hSfulNlVJtmbijOOi9/StSlBNHMoahUYMHVAclyNmL9m//Y259PZASB/UJ/PrcUUpe
         yXn1ajA/qC0FaZDkWu1pDAmPNF6ee3LUVLe8hgpwFk5ww7WTvn9VpJGxRJCiNoBXUU+Z
         dF2k6Ij/YNtM4xtGgQcdbtrOg7/3ZU02UrSMeGHWt1eE4U9VzoaRgzIuE7RhbIEPQsRL
         Tk5rNdLcJadpz7Zh27H/Ud47kzJLQZ8LMLXW1y2YKmKAFwTs/fV3YLNmtAKuE1ZBORUe
         +At5X2tYaHE9AgtmDrYbTOSNGj5zmdIV2eo/B1aQvXIE0lvYTrv8EqXusxgPyT3yIkuw
         4lLA==
X-Forwarded-Encrypted: i=1; AJvYcCUMO868t/V4kx4P18uHpi3Zf4YM/MoGXKZwiCu9x0uEKWEJV2Zi2O6bPtP+q9w5bRKN3aHJlrREeAGMkdj+@vger.kernel.org
X-Gm-Message-State: AOJu0YyonFPP8uy75Uzjk0ofJZPjRE3uRchUwPAv7RrjTSiMiOqOUIBY
	2eSe1UHiGXOQCU0RQul25MoLrA/GJjPsIwQxGeyuNzroj6yA0QDxA97JMSp5/p9TeUWLRnOpozh
	yV+sCs3s=
X-Gm-Gg: ATEYQzyWBNv5RCK79HLn6uOwy9zPrDsw0Z4kBOBU0yCCTStE/T4UJXJgHUzqQ31JcP+
	pXAx3w4LnAAKJA677pjw0YYvgnKY28p66bdViTYXjwq0LGJB5M1kgt0nFtqCdKUzDMHkS7LZvB2
	+skcc5IZX0TR+tWPS7rykaOZMe2diYFe9XHwt76tVDnMfNBSedSwC+utb9QGaoBRGc7usSJqPHU
	B/pVBuCcOra2fe0h/nc7afwIS0t02dxuv+V60OYuuDI8pVBp6ciVyvUNFB12avoWWcVAFqJvSFT
	bDi3L+PH8tpWMmX4emw44tVJiIh5bQXJKS/w69GMIhSEstutY2wvEVq6p2hhGDsgzTSdqmp5QAN
	9889TGuIhVBmAZqeOxyzC76sxXMvKId20KE8pSgOQgkHb8yehK5FGQUppgOP51kTKDtI4juz99o
	sKfEG0TsAM55QcDBg43FDnFnQJpmAX7bns6B9v+IA4wnCVaisQvPcl2EO5PCnJaWTONLOWC250
X-Received: by 2002:a17:906:7311:b0:b88:7093:3ca3 with SMTP id a640c23a62f3a-b9081a48372mr913221566b.23.1771961476170;
        Tue, 24 Feb 2026 11:31:16 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5d45esm453868766b.9.2026.02.24.11.31.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:31:14 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so971436066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 11:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7OVdB3JyhpPZQ8lNFuPd18VAGClvqu2rLLm+FbwQIJsk7DrpMDtJUWb3JffciaDHnaqApLgtnWFlo5NGD@vger.kernel.org
X-Received: by 2002:a17:907:3e84:b0:b87:115c:4a30 with SMTP id
 a640c23a62f3a-b9081a1d370mr795130666b.16.1771961473964; Tue, 24 Feb 2026
 11:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io> <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
In-Reply-To: <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Feb 2026 11:30:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
X-Gm-Features: AaiRm51lzHVgiYo0DfnqWCPlFyUhqEvW2vxicaMsmHyT7ntvI3WnV5io6jeF-lY
Message-ID: <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
Subject: Re: make_task_dead() & kthread_exit()
To: Christian Brauner <brauner@kernel.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>
Content-Type: multipart/mixed; boundary="000000000000366993064b96ee94"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	TAGGED_FROM(0.00)[bounces-78302-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 6FD3418C17E
X-Rspamd-Action: no action

--000000000000366993064b96ee94
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 at 08:25, Christian Brauner <brauner@kernel.org> wrote:
>
> If a kthread exits via a path that bypasses kthread_exit() (e.g.,
> make_task_dead() after an oops -- which calls do_exit() directly),
> the affinity_node remains in the global kthread_affinity_list. When
> free_kthread_struct() later frees the kthread struct, the linked list
> still references the freed memory. Any subsequent list_del() by another
> kthread in kthread_exit() writes to the freed memory:

Ugh.

So this is nasty, but I really detest the suggested fix. It just
smells wrong to have that affinity_node cleanup done in two different
places depending on how the exit is done.

IOW, I think the proper fix would be to just make sure that
kthread_exit() isn't actually ever bypassed.

Because looking at this, there are other issues with do_exit() killing
a kthread - it currently also means that kthread->result randomly
doesn't get set, for example, so kthread_stop() would appear to
basically return garbage.

No, nobody likely cares about the kthread_stop() return value for that
case, but it's an example of the same kind of "two different exit
paths, inconsistent data structures" issue.

How about something like the attached, in other words?

NOTE NOTE NOTE! This is *entirely* untested. It might do unspeakable
things to your pets, so please check it. I'm sending this patch out as
a "I really would prefer this kind of approach" example, not as
anything more than that.

Because I really think the core fundamental problem was that there
were two different exit paths that did different things, and we
shouldn't try to fix the symptoms of that problem, but instead really
fix the core issue.

Hmm?

Side note: while writing this suggested patch, I do note that this
comment is wrong:

 * When "(p->flags & PF_KTHREAD)" is set the task is a kthread and will
 * always remain a kthread.  For kthreads p->worker_private always
 * points to a struct kthread.  For tasks that are not kthreads
 * p->worker_private is used to point to other things.

because 'init_task' is marked as PF_KTHREAD, but does *not* have a
p->worker_private.

Anyway, that doesn't affect this particular code, but it might be
worth thinking about.

               Linus

--000000000000366993064b96ee94
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mm101azr0>
X-Attachment-Id: f_mm101azr0

IGluY2x1ZGUvbGludXgva3RocmVhZC5oIHwgMjEgKysrKysrKysrKysrKysrKysrKystCiBrZXJu
ZWwvZXhpdC5jICAgICAgICAgICB8ICA2ICsrKysrKwoga2VybmVsL2t0aHJlYWQuYyAgICAgICAg
fCA0MSArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2t0aHJlYWQuaCBiL2luY2x1ZGUvbGludXgva3RocmVhZC5oCmluZGV4IGM5
MmMxMTQ5ZWU2ZS4uYTI3OWI2MjZkODU0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2t0aHJl
YWQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2t0aHJlYWQuaApAQCAtNyw2ICs3LDI0IEBACiAKIHN0
cnVjdCBtbV9zdHJ1Y3Q7CiAKKy8qIE9wYXF1ZSBrdGhyZWFkIGRhdGEsIGludGVybmFsIHRvIGtl
cm5lbC90aHJlYWQuYyAqLworc3RydWN0IGt0aHJlYWQ7CisKKy8qCisgKiBXaGVuICIocC0+Zmxh
Z3MgJiBQRl9LVEhSRUFEKSIgaXMgc2V0IHRoZSB0YXNrIGlzIGEga3RocmVhZCBhbmQgd2lsbAor
ICogYWx3YXlzIHJlbWFpbiBhIGt0aHJlYWQuICBGb3Iga3RocmVhZHMgcC0+d29ya2VyX3ByaXZh
dGUgYWx3YXlzCisgKiBwb2ludHMgdG8gYSBzdHJ1Y3Qga3RocmVhZC4gIEZvciB0YXNrcyB0aGF0
IGFyZSBub3Qga3RocmVhZHMKKyAqIHAtPndvcmtlcl9wcml2YXRlIGlzIHVzZWQgdG8gcG9pbnQg
dG8gb3RoZXIgdGhpbmdzLgorICoKKyAqIFJldHVybiBOVUxMIGZvciBhbnkgdGFzayB0aGF0IGlz
IG5vdCBhIGt0aHJlYWQuCisgKi8KK3N0YXRpYyBpbmxpbmUgc3RydWN0IGt0aHJlYWQgKnRza19p
c19rdGhyZWFkKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKK3sKKwlpZiAocC0+ZmxhZ3MgJiBQRl9L
VEhSRUFEKQorCQlyZXR1cm4gcC0+d29ya2VyX3ByaXZhdGU7CisJcmV0dXJuIE5VTEw7Cit9CisK
IF9fcHJpbnRmKDQsIDUpCiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmt0aHJlYWRfY3JlYXRlX29uX25v
ZGUoaW50ICgqdGhyZWFkZm4pKHZvaWQgKmRhdGEpLAogCQkJCQkgICB2b2lkICpkYXRhLApAQCAt
OTgsOSArMTE2LDEwIEBAIHZvaWQgKmt0aHJlYWRfcHJvYmVfZGF0YShzdHJ1Y3QgdGFza19zdHJ1
Y3QgKmspOwogaW50IGt0aHJlYWRfcGFyayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKmspOwogdm9pZCBr
dGhyZWFkX3VucGFyayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKmspOwogdm9pZCBrdGhyZWFkX3Bhcmtt
ZSh2b2lkKTsKLXZvaWQga3RocmVhZF9leGl0KGxvbmcgcmVzdWx0KSBfX25vcmV0dXJuOworI2Rl
ZmluZSBrdGhyZWFkX2V4aXQocmVzdWx0KSBkb19leGl0KHJlc3VsdCkKIHZvaWQga3RocmVhZF9j
b21wbGV0ZV9hbmRfZXhpdChzdHJ1Y3QgY29tcGxldGlvbiAqLCBsb25nKSBfX25vcmV0dXJuOwog
aW50IGt0aHJlYWRzX3VwZGF0ZV9ob3VzZWtlZXBpbmcodm9pZCk7Cit2b2lkIGt0aHJlYWRfZG9f
ZXhpdChzdHJ1Y3Qga3RocmVhZCAqLCBsb25nKTsKIAogaW50IGt0aHJlYWRkKHZvaWQgKnVudXNl
ZCk7CiBleHRlcm4gc3RydWN0IHRhc2tfc3RydWN0ICprdGhyZWFkZF90YXNrOwpkaWZmIC0tZ2l0
IGEva2VybmVsL2V4aXQuYyBiL2tlcm5lbC9leGl0LmMKaW5kZXggOGE4NzAyMTIxMWFlLi5lZGUz
MTE3ZmE3ZDQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9leGl0LmMKKysrIGIva2VybmVsL2V4aXQuYwpA
QCAtODk2LDExICs4OTYsMTYgQEAgc3RhdGljIHZvaWQgc3luY2hyb25pemVfZ3JvdXBfZXhpdChz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgbG9uZyBjb2RlKQogdm9pZCBfX25vcmV0dXJuIGRvX2V4
aXQobG9uZyBjb2RlKQogewogCXN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrID0gY3VycmVudDsKKwlz
dHJ1Y3Qga3RocmVhZCAqa3RocmVhZDsKIAlpbnQgZ3JvdXBfZGVhZDsKIAogCVdBUk5fT04oaXJx
c19kaXNhYmxlZCgpKTsKIAlXQVJOX09OKHRzay0+cGx1Zyk7CiAKKwlrdGhyZWFkID0gdHNrX2lz
X2t0aHJlYWQodHNrKTsKKwlpZiAodW5saWtlbHkoa3RocmVhZCkpCisJCWt0aHJlYWRfZG9fZXhp
dChrdGhyZWFkLCBjb2RlKTsKKwogCWtjb3ZfdGFza19leGl0KHRzayk7CiAJa21zYW5fdGFza19l
eGl0KHRzayk7CiAKQEAgLTEwMTMsNiArMTAxOCw3IEBAIHZvaWQgX19ub3JldHVybiBkb19leGl0
KGxvbmcgY29kZSkKIAlsb2NrZGVwX2ZyZWVfdGFzayh0c2spOwogCWRvX3Rhc2tfZGVhZCgpOwog
fQorRVhQT1JUX1NZTUJPTChkb19leGl0KTsKIAogdm9pZCBfX25vcmV0dXJuIG1ha2VfdGFza19k
ZWFkKGludCBzaWducikKIHsKZGlmZiAtLWdpdCBhL2tlcm5lbC9rdGhyZWFkLmMgYi9rZXJuZWwv
a3RocmVhZC5jCmluZGV4IDIwNDUxYjYyNGI2Ny4uNzkxMjEwZGFmOGI0IDEwMDY0NAotLS0gYS9r
ZXJuZWwva3RocmVhZC5jCisrKyBiL2tlcm5lbC9rdGhyZWFkLmMKQEAgLTg1LDI0ICs4NSw2IEBA
IHN0YXRpYyBpbmxpbmUgc3RydWN0IGt0aHJlYWQgKnRvX2t0aHJlYWQoc3RydWN0IHRhc2tfc3Ry
dWN0ICprKQogCXJldHVybiBrLT53b3JrZXJfcHJpdmF0ZTsKIH0KIAotLyoKLSAqIFZhcmlhbnQg
b2YgdG9fa3RocmVhZCgpIHRoYXQgZG9lc24ndCBhc3N1bWUgQHAgaXMgYSBrdGhyZWFkLgotICoK
LSAqIFdoZW4gIihwLT5mbGFncyAmIFBGX0tUSFJFQUQpIiBpcyBzZXQgdGhlIHRhc2sgaXMgYSBr
dGhyZWFkIGFuZCB3aWxsCi0gKiBhbHdheXMgcmVtYWluIGEga3RocmVhZC4gIEZvciBrdGhyZWFk
cyBwLT53b3JrZXJfcHJpdmF0ZSBhbHdheXMKLSAqIHBvaW50cyB0byBhIHN0cnVjdCBrdGhyZWFk
LiAgRm9yIHRhc2tzIHRoYXQgYXJlIG5vdCBrdGhyZWFkcwotICogcC0+d29ya2VyX3ByaXZhdGUg
aXMgdXNlZCB0byBwb2ludCB0byBvdGhlciB0aGluZ3MuCi0gKgotICogUmV0dXJuIE5VTEwgZm9y
IGFueSB0YXNrIHRoYXQgaXMgbm90IGEga3RocmVhZC4KLSAqLwotc3RhdGljIGlubGluZSBzdHJ1
Y3Qga3RocmVhZCAqX190b19rdGhyZWFkKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKLXsKLQl2b2lk
ICprdGhyZWFkID0gcC0+d29ya2VyX3ByaXZhdGU7Ci0JaWYgKGt0aHJlYWQgJiYgIShwLT5mbGFn
cyAmIFBGX0tUSFJFQUQpKQotCQlrdGhyZWFkID0gTlVMTDsKLQlyZXR1cm4ga3RocmVhZDsKLX0K
LQogdm9pZCBnZXRfa3RocmVhZF9jb21tKGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9zaXplLCBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnRzaykKIHsKIAlzdHJ1Y3Qga3RocmVhZCAqa3RocmVhZCA9IHRvX2t0
aHJlYWQodHNrKTsKQEAgLTE5Myw3ICsxNzUsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChrdGhyZWFk
X3Nob3VsZF9wYXJrKTsKIAogYm9vbCBrdGhyZWFkX3Nob3VsZF9zdG9wX29yX3Bhcmsodm9pZCkK
IHsKLQlzdHJ1Y3Qga3RocmVhZCAqa3RocmVhZCA9IF9fdG9fa3RocmVhZChjdXJyZW50KTsKKwlz
dHJ1Y3Qga3RocmVhZCAqa3RocmVhZCA9IHRza19pc19rdGhyZWFkKGN1cnJlbnQpOwogCiAJaWYg
KCFrdGhyZWFkKQogCQlyZXR1cm4gZmFsc2U7CkBAIC0yMzQsNyArMjE2LDcgQEAgRVhQT1JUX1NZ
TUJPTF9HUEwoa3RocmVhZF9mcmVlemFibGVfc2hvdWxkX3N0b3ApOwogICovCiB2b2lkICprdGhy
ZWFkX2Z1bmMoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrKQogewotCXN0cnVjdCBrdGhyZWFkICpr
dGhyZWFkID0gX190b19rdGhyZWFkKHRhc2spOworCXN0cnVjdCBrdGhyZWFkICprdGhyZWFkID0g
dHNrX2lzX2t0aHJlYWQodGFzayk7CiAJaWYgKGt0aHJlYWQpCiAJCXJldHVybiBrdGhyZWFkLT50
aHJlYWRmbjsKIAlyZXR1cm4gTlVMTDsKQEAgLTI2Niw3ICsyNDgsNyBAQCBFWFBPUlRfU1lNQk9M
X0dQTChrdGhyZWFkX2RhdGEpOwogICovCiB2b2lkICprdGhyZWFkX3Byb2JlX2RhdGEoc3RydWN0
IHRhc2tfc3RydWN0ICp0YXNrKQogewotCXN0cnVjdCBrdGhyZWFkICprdGhyZWFkID0gX190b19r
dGhyZWFkKHRhc2spOworCXN0cnVjdCBrdGhyZWFkICprdGhyZWFkID0gdHNrX2lzX2t0aHJlYWQo
dGFzayk7CiAJdm9pZCAqZGF0YSA9IE5VTEw7CiAKIAlpZiAoa3RocmVhZCkKQEAgLTMwOSwxOSAr
MjkxLDggQEAgdm9pZCBrdGhyZWFkX3BhcmttZSh2b2lkKQogfQogRVhQT1JUX1NZTUJPTF9HUEwo
a3RocmVhZF9wYXJrbWUpOwogCi0vKioKLSAqIGt0aHJlYWRfZXhpdCAtIENhdXNlIHRoZSBjdXJy
ZW50IGt0aHJlYWQgcmV0dXJuIEByZXN1bHQgdG8ga3RocmVhZF9zdG9wKCkuCi0gKiBAcmVzdWx0
OiBUaGUgaW50ZWdlciB2YWx1ZSB0byByZXR1cm4gdG8ga3RocmVhZF9zdG9wKCkuCi0gKgotICog
V2hpbGUga3RocmVhZF9leGl0IGNhbiBiZSBjYWxsZWQgZGlyZWN0bHksIGl0IGV4aXN0cyBzbyB0
aGF0Ci0gKiBmdW5jdGlvbnMgd2hpY2ggZG8gc29tZSBhZGRpdGlvbmFsIHdvcmsgaW4gbm9uLW1v
ZHVsYXIgY29kZSBzdWNoIGFzCi0gKiBtb2R1bGVfcHV0X2FuZF9rdGhyZWFkX2V4aXQgY2FuIGJl
IGltcGxlbWVudGVkLgotICoKLSAqIERvZXMgbm90IHJldHVybi4KLSAqLwotdm9pZCBfX25vcmV0
dXJuIGt0aHJlYWRfZXhpdChsb25nIHJlc3VsdCkKK3ZvaWQga3RocmVhZF9kb19leGl0KHN0cnVj
dCBrdGhyZWFkICprdGhyZWFkLCBsb25nIHJlc3VsdCkKIHsKLQlzdHJ1Y3Qga3RocmVhZCAqa3Ro
cmVhZCA9IHRvX2t0aHJlYWQoY3VycmVudCk7CiAJa3RocmVhZC0+cmVzdWx0ID0gcmVzdWx0Owog
CWlmICghbGlzdF9lbXB0eSgma3RocmVhZC0+YWZmaW5pdHlfbm9kZSkpIHsKIAkJbXV0ZXhfbG9j
aygma3RocmVhZF9hZmZpbml0eV9sb2NrKTsKQEAgLTMzMyw5ICszMDQsNyBAQCB2b2lkIF9fbm9y
ZXR1cm4ga3RocmVhZF9leGl0KGxvbmcgcmVzdWx0KQogCQkJa3RocmVhZC0+cHJlZmVycmVkX2Fm
ZmluaXR5ID0gTlVMTDsKIAkJfQogCX0KLQlkb19leGl0KDApOwogfQotRVhQT1JUX1NZTUJPTChr
dGhyZWFkX2V4aXQpOwogCiAvKioKICAqIGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQgLSBFeGl0
IHRoZSBjdXJyZW50IGt0aHJlYWQuCkBAIC02ODMsNyArNjUyLDcgQEAgdm9pZCBrdGhyZWFkX3Nl
dF9wZXJfY3B1KHN0cnVjdCB0YXNrX3N0cnVjdCAqaywgaW50IGNwdSkKIAogYm9vbCBrdGhyZWFk
X2lzX3Blcl9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpwKQogewotCXN0cnVjdCBrdGhyZWFkICpr
dGhyZWFkID0gX190b19rdGhyZWFkKHApOworCXN0cnVjdCBrdGhyZWFkICprdGhyZWFkID0gdHNr
X2lzX2t0aHJlYWQocCk7CiAJaWYgKCFrdGhyZWFkKQogCQlyZXR1cm4gZmFsc2U7CiAK
--000000000000366993064b96ee94--

