Return-Path: <linux-fsdevel+bounces-16935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD08A529D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAA71C21EC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF917442E;
	Mon, 15 Apr 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqUoMjEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="osTRqFpm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqUoMjEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="osTRqFpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE574429;
	Mon, 15 Apr 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189828; cv=none; b=WxyYxFLWEXZG1AyiaVq87Ou7WIr1RLocwAVYhjZjx7SjrDLsCNZvkPslAPu8MECN90e3PdohmgV0WDUcIWlTZmOeSE9mDx6ZkjyQn8YaxErf4QwFhE147bpaNWHAZGb3rkrat9YeIUsRV2NWOErBEgUHGUgfpMg/01isqUIw+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189828; c=relaxed/simple;
	bh=X5u3Hp5FpH+VSEtFXU/2sqUIU4Yo4zzSzaC5G5soBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+AExo7MmNQs/Bjz1oX3OYmhqtzjDlCOtU+8H6aLoL79mx7tzA8hzi3KXgJ7xPVFgzz1gQcFXztmRgK8a5jXNZGGpsNFlCO3UPbFCGGGBA8JRKhTpauY8i3mi04jF8qq7G1cxuBbY4oDkJjRa6IWnk3PKRwAbCqTvRxrkG590M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqUoMjEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=osTRqFpm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqUoMjEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=osTRqFpm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 185475D098;
	Mon, 15 Apr 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713189818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STJDXp5HvjNpUe5L7ZwSsn731sv2lCaIwuGesf5u/P8=;
	b=jqUoMjEoX6UTknuRVD6qwD3XSBJ5NKYcIWXRZgTSL65u1Wg6ZNGVw7CkarVX9VAfjT5Ph+
	ffT2vQdZcrOq0HNn4hkdT+2s3tzmo4C5XA5m3meP7opV7LKeLYYPkmTeSQTqnn2bb6n3yv
	A/8g6KF2xJgULKdgBhik95xn9scWFoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713189818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STJDXp5HvjNpUe5L7ZwSsn731sv2lCaIwuGesf5u/P8=;
	b=osTRqFpmAvTrpNcaoDbS3LRQ4ofGZvbImvjdTWjDxP8n18EHQtNWEl1Ycqsb9cUW9XXT4B
	EKCs2E4UBWnwBVCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713189818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STJDXp5HvjNpUe5L7ZwSsn731sv2lCaIwuGesf5u/P8=;
	b=jqUoMjEoX6UTknuRVD6qwD3XSBJ5NKYcIWXRZgTSL65u1Wg6ZNGVw7CkarVX9VAfjT5Ph+
	ffT2vQdZcrOq0HNn4hkdT+2s3tzmo4C5XA5m3meP7opV7LKeLYYPkmTeSQTqnn2bb6n3yv
	A/8g6KF2xJgULKdgBhik95xn9scWFoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713189818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STJDXp5HvjNpUe5L7ZwSsn731sv2lCaIwuGesf5u/P8=;
	b=osTRqFpmAvTrpNcaoDbS3LRQ4ofGZvbImvjdTWjDxP8n18EHQtNWEl1Ycqsb9cUW9XXT4B
	EKCs2E4UBWnwBVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AB001386E;
	Mon, 15 Apr 2024 14:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YXSVArozHWaeIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Apr 2024 14:03:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81B6AA0817; Mon, 15 Apr 2024 16:03:33 +0200 (CEST)
Date: Mon, 15 Apr 2024 16:03:33 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in
 fsnotify
Message-ID: <20240415140333.y44rk5ggbadv4oej@quack3>
References: <00000000000095bb400615f4b0ed@google.com>
 <20240413084519.1774-1-hdanton@sina.com>
 <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[5e3f9b2a67b45f16d4e6];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sina.com,suse.cz,syzkaller.appspotmail.com,vger.kernel.org,googlegroups.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Sat 13-04-24 12:32:32, Amir Goldstein wrote:
> On Sat, Apr 13, 2024 at 11:45 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> > > On Sat, Apr 13, 2024 at 4:41=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrote:
> > > > On Thu, 11 Apr 2024 01:11:20 -0700
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> > > > > git tree:       linux-next
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d180000
> > > >
> > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  6ebf211bb11d
> > > >
> > > > --- x/fs/notify/fsnotify.c
> > > > +++ y/fs/notify/fsnotify.c
> > > > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > > >         wait_var_event(fsnotify_sb_watched_objects(sb),
> > > >                        !atomic_long_read(fsnotify_sb_watched_objects(sb)));
> > > >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
> > > > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > > > -                                                 FSNOTIFY_PRIO_PRE_CONTENT));
> > > > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_CONTENT));
> > > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > > >         kfree(sbinfo);
> > > >  }
> > > >
> > > > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> > > >  {
> > > >         const struct path *path =3D fsnotify_data_path(data, data_type);
> > > >         struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> > > > -       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> > > > +       struct fsnotify_sb_info *sbinfo;
> > > >         struct fsnotify_iter_info iter_info = {};
> > > >         struct mount *mnt =3D NULL;
> > > >         struct inode *inode2 =3D NULL;
> > > > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> > > >                 inode2_type =3D FSNOTIFY_ITER_TYPE_PARENT;
> > > >         }
> > > >
> > > > +       iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> > > > +       sbinfo =3D fsnotify_sb_info(sb);
> > > >         /*
> > > >          * Optimization: srcu_read_lock() has a memory barrier which can
> > > >          * be expensive.  It protects walking the *_fsnotify_marks lists.
> > >
> > >
> > > See comment above. This kills the optimization.
> > > It is not worth letting all the fsnotify hooks suffer the consequence
> > > for the edge case of calling fsnotify hook during fs shutdown.
> >
> > Say nothing before reading your fix.
> > >
> > > Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
> > > is also not protected and using srcu_read_lock() there completely
> > > nullifies the purpose of fsnotify_sb_info.
> > >
> > > Here is a simplified fix for fsnotify_sb_error() rebased on the
> > > pending mm fixes for this syzbot boot failure:
> > >
> > > #syz test: https://github.com/amir73il/linux fsnotify-fixes
> >
> > Feel free to post your patch at lore because not everyone has
> > access to sites like github.
> > >
> > > Jan,
> > >
> > > I think that all the functions called from fs shutdown context
> > > should observe that SB_ACTIVE is cleared but wasn't sure?
> >
> > If you composed fix based on SB_ACTIVE that is cleared in
> > generic_shutdown_super() with &sb->s_umount held for write,
> > I wonder what simpler serialization than srcu you could
> > find/create in fsnotify.
> 
> As far as I can tell there is no need for serialisation.
> 
> The problem is that fsnotify_sb_error() can be called from the
> context of ->put_super() call from generic_shutdown_super().
> 
> It's true that in the repro the thread calling fsnotify_sb_error()
> in the worker thread running quota deferred work from put_super()
> but I think there are sufficient barriers for this worker thread to
> observer the cleared SB_ACTIVE flag.
> 
> Anyway, according to syzbot, repro does not trigger the UAF
> with my last fix.
> 
> To be clear, any fsnotify_sb_error() that is a result of a user operation
> would be holding an active reference to sb so cannot race with
> fsnotify_sb_delete(), but I am not sure that same is true for ext4
> worker threads.
> 
> Jan,
> 
> You wrote that "In theory these two calls can even run in parallel
> and fsnotify() can be holding fsnotify_sb_info pointer while
> fsnotify_sb_delete() is freeing".
> 
> Can you give an example of this case?

Yeah, basically what Hilf writes:

Task 1					Task 2
  umount()				some delayed work, transaction
					  commit, whatever is still running
					  before ext4_put_super() completes
    ...					    ext4_error()
					      fsnotify_sb_error()
						fsnotify()
						  fetches fsnotify_sb_info
    generic_shutdown_super()
      fsnotify_sb_delete()
	frees fsnotify_sb_info

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

