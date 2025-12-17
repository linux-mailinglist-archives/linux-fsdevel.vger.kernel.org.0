Return-Path: <linux-fsdevel+bounces-71551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3BCC721B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D98930157F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541539656C;
	Wed, 17 Dec 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/0eL6cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D1397D35
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967291; cv=none; b=NstmlYTfXgzoy6cCAieUeMqIE/cO/ZDy7X9pbAKxw4S/Aj7OXR6MgvEzkVyXikYOPpHnhDV9+2sRu7Rko9Z/00zHCZ6zcfaZgxqccYwsXWi4O9ax4YWywT/27TmUg4iFh8noj3V9QWgy90ywBS/t1sx5zMY5vK07R6uLimRPvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967291; c=relaxed/simple;
	bh=J/7BDu6n95oROxSkedq0u6+yXoYeZFtAce2na6Zi9tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWZnbtFF1n9ubxBNjoxbmegwvVYuOSGlA73YzSuZ1U/AEoCUKqEl1N6ZinKjGcUJWXldShX5T9YC1WMSf746Isadj85FkOsYRuErXlPwjRJzQUJ2ZuLg0EupDNZ2FAz4a86r0Qm+7KRbiOC5AWfMQ94uMVz5JSuQ8vp88mw4wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/0eL6cY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-649784c8967so7527705a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765967284; x=1766572084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN9SFKhLyN+I3oBfhugiol4dWQKyAR0DNjZxzXEOgl8=;
        b=g/0eL6cYYUIBXLhEmGTN+Hczzjv5YOxmh+AWOmTA7ACsBhdyJ6O6pWeJCZJmogm3Ih
         F0KRBllZbIKBz2YTnSutq5S7cJLuN3EzH1pCQd9vH0Zn0Ea4NwgNfy/fifhORG5QjkDO
         J6wvB8nAh4joYzpfat1rivXO/PfxGWcmA0CIVw+mB5OHArNxGIfbMEFUHtkVsz0+4CFx
         u3tFd+hqG577S7aazOGHED0WWrQtYoSmeVQkQMmldSMd5Cq52w7AsVelIOZW9DsJxfDq
         XFK32tGhHDpsR8V8n+b7h4woaBMByBsIexcqvIU80p+QGxWt6b27EOZ72dSaoxKkEEKz
         HeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967284; x=1766572084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fN9SFKhLyN+I3oBfhugiol4dWQKyAR0DNjZxzXEOgl8=;
        b=I5e2aCbt8rRZMRFCttKrrKD53hYi1P4FKegrHHP+27ebsxPLoF3gDwr0+ekRW+NcSA
         iyDT//Tn0gvWyl5DLjxEqeVWG7FdE1+QSSjSyt7aWVXKM1HGJWdKGDI7R+HGMdmnUxuw
         TWFlI+uYxsrAul709tfczuU49KeveJNbbxjFIjja24SH8Y48G7UeRtmjTreNE543FW72
         LqhCXKsm+T8f/WyJKKnZxuv7MBuYRc3o2V/tl8+xNl4lb8bsu19FsDxq8H7a64pQePf/
         JV3aHZ7mIaHslGt1Imp2ZIgjVLwTxPMN1SrLR18WPlmXqH6shC9fUpjIocBvJA8bzss6
         iSSg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Le/BkoI0poMIajq/iBOL5Vc8WDl1rgKCt6OIsxnqzMMeR/fWgzDBFgsJcBKnYplJEJTQbHpiVADTeG72@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkqv6JrgLa13ziYl4BtSQ3C0qvBwlnLF3UqLjKGqCPZgYZHivg
	CG3uG1GJTuITb3N5qufsIb86wrcxdlMJnI3Qf6OVHXsist5lcHzq8fymLFu+Axsfl/nix9TV4Ss
	eLV90F3BdtMPkxacLgw5aGYwxokYZIno=
X-Gm-Gg: AY/fxX484BXOzh/+ilom6tAEBXLdjPohaPm7tf7mk1LHAb9SqDoMnw+x7wgfQjXoI8X
	XWilrgj1CBPXpkSqbaMpylwg3GRWAB1aYceAZXfYCPAFuBNwiumewlkbswGWfV2dPlJZgiILjtR
	7Jr+YINIxnJn5y1+kUVvTz5kukanH5HM6Iw3C3Y/wxae+yYufpmQxvvq0D3sRqGmnCD6z3MdYd7
	d80NLZfun9CRo0YjEwxB2ptxb4nB9e5RFZQ2s8ZxwBcljFHSOgmJAeyqYdQWlsw4vnVT3kbtZO2
	CwELocXC9X3lm1+75tKz+7seJ1Y=
X-Google-Smtp-Source: AGHT+IGxuLgyesKlrw6CdZX+kdBS65NokUagoBUPMiQ+O+CoHl1UW1jm+xmfaR5FSdSpmeZ8qXg7/Y00e1OLgYmLrhQ=
X-Received: by 2002:a17:907:6e90:b0:b73:78f3:15c1 with SMTP id
 a640c23a62f3a-b7d23b92012mr1622310766b.52.1765967283959; Wed, 17 Dec 2025
 02:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217084704.2323682-1-mjguzik@gmail.com> <20251217090833.GS1712166@ZenIV>
 <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com>
 <20251217100605.GT1712166@ZenIV> <CAGudoHFLV5sHE1UBXR5BtPHUghnroA=m59D6yBknWnZz0mkS7A@mail.gmail.com>
In-Reply-To: <CAGudoHFLV5sHE1UBXR5BtPHUghnroA=m59D6yBknWnZz0mkS7A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Dec 2025 11:27:51 +0100
X-Gm-Features: AQt7F2pRhnUgowhgILLOmbgYD-lLdsuHYLpVqJO-oYaFzNdK2EdP_042vf0AWds
Message-ID: <CAGudoHEvOXqOCiva4PFU=8d-j3C2qv986864eqPWTtZwTk6KDg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:13=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Wed, Dec 17, 2025 at 11:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > On Wed, Dec 17, 2025 at 10:11:04AM +0100, Mateusz Guzik wrote:
> > > On Wed, Dec 17, 2025 at 10:07=E2=80=AFAM Al Viro <viro@zeniv.linux.or=
g.uk> wrote:
> > > >
> > > > On Wed, Dec 17, 2025 at 09:47:04AM +0100, Mateusz Guzik wrote:
> > > > > One remaining weirdness is terminate_walk() walking the symlink s=
tack
> > > > > after drop_links().
> > > >
> > > > What weirdness?  If we are not in RCU mode, we need to drop symlink=
 bodies
> > > > *and* drop symlink references?
> > >
> > > One would expect a routine named drop_links() would handle the
> > > entirety of clean up of symlinks.
> > >
> > > Seeing how it only handles some of it, it should be renamed to better
> > > indicate what it is doing, but that's a potential clean up for later.
> >
> > Take a look at the callers.  All 3 of them.
> >
> > 1) terminate_walk(): drop all symlink bodies, in non-RCU mode drop
> > all paths as well.
> >
> > 2) a couple in legitimize_links(): *always* called in RCU mode.  That's
> > the whole point - trying to grab references to a bunch of dentries/moun=
ts,
> > so that we could continue in non-RCU mode from that point on.  What sho=
uld
> > we do if we'd grabbed some of those references, but failed halfway thro=
ugh
> > the stack?
> >
> > We *can't* do path_put() there - not under rcu_read_lock().  And we can=
't
> > delay dropping the link bodies past rcu_read_unlock().
> >
> > Note that this state has
> >         nd->depth link bodies in stack, all need to be droped before
> > rcu_read_unlock()
> >         first K link references in stack that need to be dropped after
> > rcu_read_unlock()
> >         nd->depth - K link references in stack that do _not_ need to
> > be dropped.
> >
> > Solution: have link bodies dropped, callbacks cleared and nd->depth
> > reset to K.  The caller of legitimate_links() immediately drops out
> > of RCU mode and we proceed to terminate_walk(), same as we would
> > on an error in non-RCU mode.
> >
> > This case is on a slow path; we could microoptimize it, but result
> > would be really harder to understand.
>
> I'm not arguing for drop_links() to change behavior, but for it to be
> renamed to something which indicates there is still potential
> symlink-related clean up to do.
>
> As an outsider, a routine named drop_${whatever} normally suggests the
> ${whatever} is fully taken care of after the call, which is not the
> case here.

Completely untested clean up for illustrative purposes:
static void links_issue_delayed_calls(struct nameidata *nd)
{
        int i =3D nd->depth;
        while (i--) {
                struct saved *last =3D nd->stack + i;
                do_delayed_call(&last->done);
                clear_delayed_call(&last->done);
        }
}

static void links_cleanup_rcu(struct nameidata *nd)
{
        VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));

        if (likely(!nd->depth))
                return;

        links_issue_delayed_calls(nd);
        nd->depth =3D 0;
}

static void links_cleanup_ref(struct nameidata *nd)
{
        VFS_BUG_ON(nd->flags & LOOKUP_RCU);

        if (likely(!nd->depth))
                return;

        links_issue_delayed_calls(nd);

        path_put(&nd->path);
        for (int i =3D 0; i < nd->depth; i++)
                path_put(&nd->stack[i].link);
        if (nd->state & ND_ROOT_GRABBED) {
                path_put(&nd->root);
                nd->state &=3D ~ND_ROOT_GRABBED;
        }
        nd->depth =3D 0;
}

static void leave_rcu(struct nameidata *nd)
{
        nd->flags &=3D ~LOOKUP_RCU;
        nd->seq =3D nd->next_seq =3D 0;
        rcu_read_unlock();
}

static void terminate_walk(struct nameidata *nd)
{
        if (nd->flags & LOOKUP_RCU) {
                links_cleanup_rcu(nd);
                leave_rcu(nd);
        } else {
                links_cleanup_ref(nd);
        }
        VFS_BUG_ON(nd->depth);
        nd->path.mnt =3D NULL;
        nd->path.dentry =3D NULL;
}

