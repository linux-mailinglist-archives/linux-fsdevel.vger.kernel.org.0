Return-Path: <linux-fsdevel+bounces-55475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AECB0AAD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55E25A3F88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B550209F45;
	Fri, 18 Jul 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfDOgaJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4C1E3DDE;
	Fri, 18 Jul 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868633; cv=none; b=ZtrDcjDCsXy/vJDrF19K9KrshEcEXwl6sAlnK/o8zDzvf+WJovVJrjRN+R+CD1hkHmcJrHdBbj5VgoG88a/FrtTSsfCBl4yxGXAamtiBhYRRHyxLR183ESW9D4fPktf7Qzc9fnN83wztmxGZvNIMkbaatwq+nDidF7I7ktpCG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868633; c=relaxed/simple;
	bh=oKaZCZ5M8Rin3ZUrdwGRxTLD/62MDgbRsBhC+e4MP5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvCcQj4FRev8M7+H8/PWJF9i/GKfQdS2zHS08Z+XI/pYyGm3dyiJS9Nuviol+shObbTx5M7d8xboH0bI6gSNyMRe6hoOVagxaAKK4jN7Iusyih1PP8nrK0+7WhitpCwJOmgBRXp6MjzHo1Y3VM8BFRMFII5M3DRFUMfuhQ35KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfDOgaJj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso488955866b.2;
        Fri, 18 Jul 2025 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752868630; x=1753473430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpW+/d7N53k/VUFOpznWi5Skx13Cj5jADSSDp/BpMvA=;
        b=gfDOgaJjTss8fnQXN0U1pxACe0eHHISRAlAwtCZ596Sa9jqSmPepi4wCh2wCqC+UIe
         +YmFGNwjCwr+rVwn+JvrsZVXXI0qCErJdsJBzA6iTbfJJUJSuNYTcH9894YaOqYnH+HH
         FUWhFtjzOcdVc+mCgbtOVyIfiH2WnJd3ADFcUMxEMeLmF8lPrtrZSJzM7eSQEhRC2P8w
         NRMXum2009aXfv9sCGq064JTABL8r1hZpvXsNzxy/VDi8OdAvHwDtzxYAe6KxoLPjkge
         UR44p2sXrgSYKTZgn4/w+sOWYonSeq7QKnNCLBv/I7SiujlrIJxV3+H7h3hFejJ+G0vw
         VA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752868630; x=1753473430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpW+/d7N53k/VUFOpznWi5Skx13Cj5jADSSDp/BpMvA=;
        b=cGITrxc8GK6dCJs9IEVa8TP8fgQVb575oeFCfPI3zQPFgKGszH4LiWy7W3CHvGNB97
         LP124ZcgIsea0c4GGJCZZjMHijhuJP2miQWUB04ajryKBXDKEaD1E6RrhfbnGCEjQet6
         xa6aOF7pBoi+jKeMp1sGU2bfCAhEedhW1kqvZHIbFWMxTfaL9js8UXQee4SQwAwbNpvv
         dwe6t93em2Jw8rBtMOsf52HOLQQxBXiRpQJ6GMqSe6BwqBxm0MU+s9PgB/+dx4rgJvdT
         53iC+OMtW/KnZXoX48WZonYmjs4RDZkW8vokxcb9HIMBixkvCuTuoc07acTRYx64ioWL
         BW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaPVoKduovM4QEFVMjtY1p7KAqy5wldo/GAvQ3zJ2DcDAJVX3R1/UpIn7x9lW9H9YbZQJFiJKt0diT@vger.kernel.org, AJvYcCWqqLOVCjTXVTPUAJbxWMoahvqUxAn3J+H4wEV3UPES1x0NVH8bAgiwxBX+qFTHSV/6VBCHdhEpZCHZhwaznA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHZ/hfnGaQ9tGhFxEZyOQj+WCpTRHtX24MQWFGnlvCaQ+PDRw
	z643vFYKY8z/DUt1kAU+BDx37XBFvlpkjN0vB6dPCgahPh/RfGH6fGB49XEpYw5d12NKcm8REzu
	B17/V5sZF+pq3RMiDDSYqoXooN5FgjAs=
X-Gm-Gg: ASbGnctywg27zEHvGhkHAfuwBtSix+8uaKw3QAw2r/IkBfBzcYt0pq30es/FFgTMnPE
	4Mz0ylRIXuC6+zYQt/C+NatN0kTfaFi2txa7efWwV1Y+qyGiqn/qTIncHMZEpFVg8NOOajUcV2/
	su+qpdqlbn3f/v3VsS4E5sU2raPElUUeVqb1SomH80KqQkrQ5MqJNjALHBCmler42vLgnTiPM+Z
	PDzmsg=
X-Google-Smtp-Source: AGHT+IGGXCsdFXiYJu//ENEwaAwoRaU1zj3kcyhlE9NFVbmHquGnOEIvo4oMStaz/jM1y6dE2k3fEBORKxfzz3/RxZM=
X-Received: by 2002:a17:907:809:b0:ae3:6659:180b with SMTP id
 a640c23a62f3a-ae9ce0d2d13mr1232764066b.29.1752868629174; Fri, 18 Jul 2025
 12:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717231038.GQ2672029@frogsfrogsfrogs> <20250718-flitzen-imker-4874d797877e@brauner>
 <CAOQ4uxgV_nJZBh4BNE+LEjCsMToHv7vSj8Ci4yJqtR-vrxb=yA@mail.gmail.com> <20250718193116.GC2672029@frogsfrogsfrogs>
In-Reply-To: <20250718193116.GC2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 21:56:56 +0200
X-Gm-Features: Ac12FXy9JTXpN54luqY8F-M21s-1_-KoNIaxZN6NT45wwyYO2w2RDv72ZrHGyiY
Message-ID: <CAOQ4uxgTtGrZ0ACuj-t3aY7dxjzbX6=69ybR7HVUcNemrTaVQQ@mail.gmail.com>
Subject: Re: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, 
	Josef Bacik <josef@toxicpanda.com>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 9:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 01:55:48PM +0200, Amir Goldstein wrote:
> > On Fri, Jul 18, 2025 at 10:54=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Thu, Jul 17, 2025 at 04:10:38PM -0700, Darrick J. Wong wrote:
> > > > Hi everyone,
> > > >
> > > > DO NOT MERGE THIS, STILL!
> > > >
> > > > This is the third request for comments of a prototype to connect th=
e
> > > > Linux fuse driver to fs-iomap for regular file IO operations to and=
 from
> > > > files whose contents persist to locally attached storage devices.
> > > >
> > > > Why would you want to do that?  Most filesystem drivers are serious=
ly
> > > > vulnerable to metadata parsing attacks, as syzbot has shown repeate=
dly
> > > > over almost a decade of its existence.  Faulty code can lead to tot=
al
> > > > kernel compromise, and I think there's a very strong incentive to m=
ove
> > > > all that parsing out to userspace where we can containerize the fus=
e
> > > > server process.
> > > >
> > > > willy's folios conversion project (and to a certain degree RH's new
> > > > mount API) have also demonstrated that treewide changes to the core
> > > > mm/pagecache/fs code are very very difficult to pull off and take y=
ears
> > > > because you have to understand every filesystem's bespoke use of th=
at
> > > > core code.  Eeeugh.
> > > >
> > > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > > ->iomap_end, and iomap ->ioend calls within iomap are turned into
> > > > upcalls to the fuse server via a trio of new fuse commands.  Pageca=
che
> > > > writeback is now a directio write.  The fuse server is now able to
> > > > upsert mappings into the kernel for cached access (=3D=3D zero upca=
lls for
> > > > rereads and pure overwrites!) and the iomap cache revalidation code
> > > > works.
> > > >
> > > > With this RFC, I am able to show that it's possible to build a fuse
> > > > server for a real filesystem (ext4) that runs entirely in userspace=
 yet
> > > > maintains most of its performance.  At this stage I still get about=
 95%
> > > > of the kernel ext4 driver's streaming directio performance on strea=
ming
> > > > IO, and 110% of its streaming buffered IO performance.  Random buff=
ered
> > > > IO is about 85% as fast as the kernel.  Random direct IO is about 8=
0% as
> > > > fast as the kernel; see the cover letter for the fuse2fs iomap chan=
ges
> > > > for more details.  Unwritten extent conversions on random direct wr=
ites
> > > > are especially painful for fuse+iomap (~90% more overhead) due to u=
pcall
> > > > overhead.  And that's with debugging turned on!
> > > >
> > > > These items have been addressed since the first RFC:
> > > >
> > > > 1. The iomap cookie validation is now present, which avoids subtle =
races
> > > > between pagecache zeroing and writeback on filesystems that support
> > > > unwritten and delalloc mappings.
> > > >
> > > > 2. Mappings can be cached in the kernel for more speed.
> > > >
> > > > 3. iomap supports inline data.
> > > >
> > > > 4. I can now turn on fuse+iomap on a per-inode basis, which turned =
out
> > > > to be as easy as creating a new ->getattr_iflags callback so that t=
he
> > > > fuse server can set fuse_attr::flags.
> > > >
> > > > 5. statx and syncfs work on iomap filesystems.
> > > >
> > > > 6. Timestamps and ACLs work the same way they do in ext4/xfs when i=
omap
> > > > is enabled.
> > > >
> > > > 7. The ext4 shutdown ioctl is now supported.
> > > >
> > > > There are some major warts remaining:
> > > >
> > > > a. ext4 doesn't support out of place writes so I don't know if that
> > > > actually works correctly.
> > > >
> > > > b. iomap is an inode-based service, not a file-based service.  This
> > > > means that we /must/ push ext2's inode numbers into the kernel via
> > > > FUSE_GETATTR so that it can report those same numbers back out thro=
ugh
> > > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate n=
odeid
> > > > to index its incore inode, so we have to pass those too so that
> > > > notifications work properly.  This is related to #3 below:
> > > >
> > > > c. Hardlinks and iomap are not possible for upper-level libfuse cli=
ents
> > > > because the upper level libfuse likes to abstract kernel nodeids wi=
th
> > > > its own homebrew dirent/inode cache, which doesn't understand hardl=
inks.
> > > > As a result, a hardlinked file results in two distinct struct inode=
s in
> > > > the kernel, which completely breaks iomap's locking model.  I will =
have
> > > > to rewrite fuse2fs for the lowlevel libfuse library to make this wo=
rk,
> > > > but on the plus side there will be far less path lookup overhead.
> > > >
> > > > d. There are too many changes to the IO manager in libext2fs becaus=
e I
> > > > built things needed to stage the direct/buffered IO paths separatel=
y.
> > > > These are now unnecessary but I haven't pulled them out yet because
> > > > they're sort of useful to verify that iomap file IO never goes thro=
ugh
> > > > libext2fs except for inline data.
> > > >
> > > > e. If we're going to use fuse servers as "safe" replacements for ke=
rnel
> > > > filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so t=
hat
> > > > fuse2fs memory allocations (in the kernel) don't push pagecache rec=
laim.
> > > > We also need to disable the OOM killer(s) for fuse servers because =
you
> > > > don't want filesystems to unmount abruptly.
> > > >
> > > > f. How do we maximally contain the fuse server to have safe filesys=
tem
> > > > mounts?  It's very convenient to use systemd services to configure
> > > > isolation declaratively, but fuse2fs still needs to be able to open
> > > > /dev/fuse, the ext4 block device, and call mount() in the shared
> > > > namespace.  This prevents us from using most of the stronger system=
d
> > >
> > > I'm happy to help you here.
> > >
> > > First, I think using a character device for namespaced drivers is alw=
ays
> > > a mistake. FUSE predates all that ofc. They're incredibly terrible fo=
r
> > > delegation because of devtmpfs not being namespaced as well as device=
s
> > > in general. And having device nodes on anything other than tmpfs is j=
ust
> > > wrong (TM).
> > >
> > > In systemd I ultimately want a bpf LSM program that prevents the
> > > creation of device nodes outside of tmpfs. They don't belong on
> > > persistent storage imho. But anyway, that's besides the point.
> > >
> > > Opening the block device should be done by systemd-mountfsd but I thi=
nk
> > > /dev/fuse should really be openable by the service itself.
>
> /me slaps his head and remembers that fsopen/fsconfig/fsmount exist.
> Can you pass an fsopen fd to an unprivileged process and have that
> second process call fsmount?
>
> If so, then it would be more convenient if mount.safe/systemd-mountfsd
> could pass open fds for /dev/fuse fsopen then the fuse server wouldn't
> need any special /dev access at all.  I think then the fuse server's
> service could have:
>
> DynamicUser=3Dtrue
> ProtectSystem=3Dtrue
> ProtectHome=3Dtrue
> PrivateTmp=3Dtrue
> PrivateDevices=3Dtrue
> DevicePolicy=3Dstrict
>
> (I think most of those are redundant with DynamicUser=3Dtrue but a lot of
> my systemd-fu is paged out ATM.)
>
> My goal here is extreme containment -- the code doing the fs metadata
> parsing has no privileges, no write access except to the fds it was
> given, no network access, and no ability to read anything outside the
> root filesystem.  Then I can get back to writing buffer
> overflows^W^Whigh quality filesystem code in peace.
>
> > > So we can try and allowlist /dev/fuse in vfs_mknod() similar to
> > > whiteouts. That means you can do mknod() in the container to create
> > > /dev/fuse (Personally, I would even restrict this to tmpfs right off =
the
> > > bat so that containers can only do this on their private tmpfs mount =
at
> > > /dev.)
> > >
> > > The downside of this would be to give unprivileged containers access =
to
> > > FUSE by default. I don't think that's a problem per se but it is a ua=
pi
> > > change.
>
> Yeah, that is a new risk.  It's still better than metadata parsing
> within the kernel address space ... though who knows how thoroughly fuse
> has been fuzzed by syzbot :P
>
> > > Let me think a bit about alternatives. I have one crazy idea but I'm =
not
> > > sure enough about it to spill it.
>
> Please do share, #f is my crazy unbaked idea. :)
>
> > I don't think there is a hard requirement for the fuse fd to be opened =
from
> > a device driver.
> > With fuse io_uring communication, the open fd doesn't even need to do i=
o.
> >
> > > > protections because they tend to run in a private mount namespace w=
ith
> > > > various parts of the filesystem either hidden or readonly.
> > > >
> > > > In theory one could design a socket protocol to pass mount options,
> > > > block device paths, fds, and responsibility for the mount() call be=
tween
> > > > a mount helper and a service:
> > >
> > > This isn't a problem really. This should just be an extension to
> > > systemd-mountfsd.
>
> I suppose mount.safe could very well call systemd-mount to go do all the
> systemd-related service setup, and that would take care of udisks as
> well.
>
> > This is relevant not only to systemd env.
> >
> > I have been experimenting with this mount helper service to mount fuse =
fs
> > inside an unprivileged kubernetes container, where opening of /dev/fuse
> > is restricted by LSM policy:
> >
> > https://github.com/pfnet-research/meta-fuse-csi-plugin?tab=3Dreadme-ov-=
file#fusermount3-proxy-modified-fusermount3-approach
>
> That sounds similar to what I was thinking about, though there are a lot
> of TLAs that I don't understand.

Heh. UDS is Unix Domain Socket if that's what you missed (?)
All the rest don't matter.
It's just a privileged service to mount fuse filesystems.
The interesting thing is the trick with replacing fusermount3
to make existing fuse filesystems work out of the box, but the
principle is simply what you described.

Thanks,
Amir.

