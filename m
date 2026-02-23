Return-Path: <linux-fsdevel+bounces-77972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF1fCiF0nGmcGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:37:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627D178D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EFB1304C7DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBC2EFDA4;
	Mon, 23 Feb 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzJl56yI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcdDc6if"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3C277029
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861017; cv=pass; b=F4xwzJ87xWSDMyOe3Op54J/eRt8V+uZbwCMMP0vlr7hkArcvsLqorYaK7f4korr/Eokpkt5k5DNKbLKFJVLLzcmsl96cHhOky1OOI7ewkg6cMMuvptZsOiowfz/XXh1KgtkPIkIqsuTap6Udr4/ACmWyRQhW7z/Q4d6GyBMTm1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861017; c=relaxed/simple;
	bh=QgzwhWHfL5HE5kt8p7liWozM4mZ4QkXl1YM7DII1drc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwR7sezUVGQU5lPfXPezPDRt+4J78BBdjHEipg+Mz5JCwnzer/DfM9tHTEzy2cKhTX1sR9xCcA3nxyi50fsdCiUHIoj/TDeEeSjyxd0VA/clYNZL2Lu/VU/2jiOciZgOKmumcJoySHtsm7qJp+SzeDNS9HpkJC59nOdEN9UVfTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzJl56yI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcdDc6if; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771861014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
	b=KzJl56yIsuRYAwz9cB0KKXU5lRT/quw3YwM1ppM2s99NyNdwx+RRx1I+5ZBf2ht0SgFLh4
	FhAVKfQqNCM7oJEbwC08JE5EaGcrPIuAqyltnl5SrsLV07LxCDMa/u+1iZBqmELd5NQ/7c
	tZIckhUmLZdDyLhDMoBI6V/v9o6cdU0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Bo0bE6CYO4GisD1H-eCMjA-1; Mon, 23 Feb 2026 10:36:52 -0500
X-MC-Unique: Bo0bE6CYO4GisD1H-eCMjA-1
X-Mimecast-MFC-AGG-ID: Bo0bE6CYO4GisD1H-eCMjA_1771861012
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64956932a51so5735901d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:36:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861012; cv=none;
        d=google.com; s=arc-20240605;
        b=AJFF7IIkplDu2OkxNXTHuHV5asadLpiHxsWYfffZ2QCQ4gELekgKbwFfiTAekOR8hs
         3/Egpsa9CGmGbhc3pgwnDQmo/TW9/9WcVWNXc69U3StlNfelbenyY/5kMKhX3dEfkYGd
         Q0hryyYwK3vtBzEgdX8a8eIsU4OP8p6+QYrpY4yLIoBFFP+8wsuWClv1h5NeFRiHULsT
         h6qgo75bQWrc+SfLZXYreSgkTLjDKluiYOJtjOtAD0kWRL3yCDmBGhpgxxmn1/y1ALSW
         cCcMNFX/U6xaSLz7SY4zBTQBDgNg33Wbfd4yo+yKuApyCYMa7YbPE8KWZ4VCooT3dqYT
         ikuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
        fh=i8X2z/5KGh1VYcELhIp9V/EkuBOMxbKDlorXa6QSO2c=;
        b=bsS8RJyampNlhjf8yJxkrmgnSKNE1HhfH3kWeOAehONs+8Kvq/n+GlzZHar5Yrl5fn
         rdt3EZeQrM2quvBJlC0+dovoFBGwcl2vsGr06+D4+yT9ICW6XltbeZGoCXtdk9ZHEil8
         xW7w7cH6zRKtVaaxZPjzGGAnBfNgdOfBcjveTpYO/fDmFBadatMA1v+0Bia3c7JdBoPE
         9PWn5+WAgxTSqgErVlC9i9WijltxLnKq5044E3N7kO2IC4l7nc+LTsCB3PNK40hjzzon
         +IvaPQYVQM4oIOYxuinh3BDPKAw8yTC9KCAPZlsXJAqiL2e62wbfAE1qgrx/5ZAr19Ox
         30tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771861012; x=1772465812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
        b=PcdDc6ifqXwzo5UQDUp2QCF+yEEHHvaHzgQ25LBZVj/yyaFgIzxZkwP2wQsMpu4crG
         VLp8+hev0zy0+e3zmnM+Xuc2BhQeg4/KE+9Nbfwj09re4SDh+lYvKqktwbOJ0JT8yFo5
         fBLkwkQq9rQKY/9VleU5CEnMzbebTqR+PG/9taXDumsRsKGyMo3eUuAR4lWF5AycGOUk
         QwDDsz1GQZY3yqY1obV8ZgOK8sEPlSLqodLu+lwgbcPOtpNCzs0ZzPMCXKIAOsGLoH0u
         thtp21JxwJcDBX1sJXYf5VjHFXR5bHbi3OFwsbEL4Wn1a8NqCH4+sk5EpC4e0bGXi6Qa
         p1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861012; x=1772465812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ya8PzuLzaDTAGKlZ38+DN9SYivC4DKKpFUaUgf5j0k=;
        b=Rie5Oxljrmn4sg0jZcG8wE5fv1gSHinApDn2zSpJqEtblm5/bE3yMzACqtgNR6LR5h
         KW/VomkHo8kwLdvq/f4W8bGvDIpXmfB2kCvTtb6FbPV2aBHIv7VzmbYwyyROS189kYv0
         F9loB3AB2Voc1VNGH1qXGdX2bvdPD1H84AqBB955f0j9/1DeKjrXZL/kmndRF5hztDvr
         NesXYm9mNaek4+73uy3GAKdD5zZci0eePF+zcrTBEr0I5UsXHRvuDzJywxLikfdWWhdq
         KzuDTd9s9ZNf/er/k1bAjuHj7b5TFV/ixrS6Big0z16OH6RlKD9+gqgKWnbo+2+vIR3F
         5KJA==
X-Forwarded-Encrypted: i=1; AJvYcCV2V3bEVIZx2/n+kyS0tFa+Y1nOPaJ5AXhYoqpLj9scYIpEGZNyO2UzltD+D83u2kUDf3k8JMWhr+ajEgQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YymwkWeqrXy2Shwl7XOO+MvBlgvFtVS6MfqAgE2g1GKHstIZWi0
	XIBbfXKw1sMIeNOtXXVJ+eXNklMh7nzVtP1X8T3CG5cehp66Ox6qms8jXbRK3NssuVXczjtQvE0
	iRDA3gVZuj5JMuUYtIDFBwIT8gyZOu4UJzerSi72s4BPDwarXrUlSLWuJ0nnpdr8SvngTpBGbNN
	Oz4C2KyU5Igpj+aNUzVrwYinrLnTCdQNxfIl5vNMjYIQ==
X-Gm-Gg: ATEYQzzP65G9WJadvr6SF0abzC2ZS4aCW9B+iAETKggIQBQdPfNULyigD99J/UGGJWa
	XUUTYiVY3W+QzTaEsbsuXkPNex1LSY6YY1/BKnu4PhfhElulqE3unYYr1IbUhayBDzwtelgUD9l
	YycFCtAdE/S9JrPKVL36Nkrf6EEl+Z9GizO32rHBkw+rNUbFsUM9GIbdxAtEHXAzGWclNfwU9oF
	iKPOmxqyFeT5HEam+uilc8EhfiiKLmJIj6Jq6+yIplOqgmS+MGMdYsM4Qz9rjjjbg==
X-Received: by 2002:a53:ac8f:0:b0:64c:9750:6b1b with SMTP id 956f58d0204a3-64c97506b96mr860686d50.40.1771861011963;
        Mon, 23 Feb 2026 07:36:51 -0800 (PST)
X-Received: by 2002:a53:ac8f:0:b0:64c:9750:6b1b with SMTP id
 956f58d0204a3-64c97506b96mr860664d50.40.1771861011520; Mon, 23 Feb 2026
 07:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com> <20260217-fanshop-akteur-af571819f78b@brauner>
 <177131956603.8396.12634282713089317@noble.neil.brown.name>
 <177136673378.8396.7219915415554001211@noble.neil.brown.name>
 <20260219-kitzeln-vielmehr-22b6ce51bf5a@brauner> <177153754005.8396.8777398743501764194@noble.neil.brown.name>
In-Reply-To: <177153754005.8396.8777398743501764194@noble.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Feb 2026 16:36:39 +0100
X-Gm-Features: AaiRm53sUjN8-cTwnNFToBiYpkAXEz9qZd9i7Z7AVLKQMvcvaqFgVcKnPAsHhs4
Message-ID: <CAHc6FU4jJ16g8nLdBdUhZDa+q0P2BJqU-5BxLAF0xWgj4ZpixA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, 
	syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77972-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9627D178D21
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:45=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
> On Thu, 19 Feb 2026, Christian Brauner wrote:
> > On Wed, Feb 18, 2026 at 09:18:53AM +1100, NeilBrown wrote:
> > > On Tue, 17 Feb 2026, NeilBrown wrote:
> > > > On Tue, 17 Feb 2026, Christian Brauner wrote:
> > > > > On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of =
git://git.k..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D153=
31c02580000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac0=
0553de86d6bf0
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ea51=
08a1f5fb4fcc2d8
> > > > > > compiler:       Debian clang version 21.1.8 (++20251221033036+2=
078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
46b295a580000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image (non-bootable): https://storage.googleapis.com/syzbo=
t-assets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71=
e9c/vmlinux-0f2acd31.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/b186=
43058ceb/bzImage-0f2acd31.xz
> > > > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/=
bbfed09077d3/mount_1.gz
> > > > > >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.lo=
g?x=3D106b295a580000)
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.=
com
> > > > >
> > > > > Neil, is this something you have time to look into?
> > > >
> > > > The reproducer appears to mount a gfs2 filesystem and mkdir 3
> > > > directories:
> > > >   ./file1
> > > >   ./file1/file4
> > > >   ./file1/file4/file7
> > > >
> > > > and somewhere in there it crashes because vfs_mkdir() returns a
> > > > non-error dentry for which ->d_parent->d_inode is not locked and
> > > > end_creating_path() tries to up_write().
> > > >
> > > > Presumably either ->d_parent has changed or the inode was unlocked?
> > > >
> > > > gfs2_mkdir() never returns a dentry, so it must be returning NULL.
> > > >
> > > > It's weird - but that is no surprise.
> > > >
> > > > I'll try building a kernel myself and see if the reproducer still f=
ires.
> > > > if so some printk tracing my reveal something.
> > >
> > > Unfortunately that didn't work out.
> > > Using the provided vmlinux and root image and repro, and a syzkaller =
I
> > > compiled from current git, I cannot trigger the crash.
> > >
> > > I'll have another look at the code but I don't hold out a lot of hope=
.
> >
> > There's at least a proper C repro now.
> >
>
> Yes - and with the new C repro I can trigger the bug.
>
> The problem is in gfs2.  gfs2_create_inode() calls d_instantiate()
> before unlock_new_inode().  This is bad.  d_instantiate_new() should be
> used, which makes sure the two things happen in the correct order.
>
> Key to understanding the problem is knowing that unlock_new_inode()
> calls lockdep_annotate_inode_mutex_key() which (potentially) calls
>   init_rwsem(&inode->i_rwsem);
>
> So if anyone has locked the inode before unlock_new_inode() is called,
> the lock is lost when i_rwsem is reinitialised.
>
> The reproducer calls mkdir("a") and mkdir("a/b") concurrently from
> separate threads.  The second mkdir() often fails (I assume) because "a"
> cannot be found.  But if that second mkdir() runs just after gfs2 has
> called d_instantiate(), then the lookup of "a" will succeed and so the
> inode will be locked ready for mkdir..  Then the mkdir("a") completes
> calling unlock_new_inode() which reinitialised i_rwsem.  When
> mkdir("a/b") comes to lock the parent, it finds that it isn't locked any
> more.
>
> There is non-trivial code between the d_instantiate() call and the
> unlock_new_inode() call which I do not understand.  So I will not
> propose a patch.  I don't know if that code should be after
> d_instantiate_new(), or before it.
>
> So I'll leave that to Andreas.

Thanks a lot, Neil, I've added a fix to for-next.

Andreas


