Return-Path: <linux-fsdevel+bounces-43016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFDA4D098
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29E516F0A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E926A33B;
	Tue,  4 Mar 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Vw96yu2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2sKQPbqO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA923F383;
	Tue,  4 Mar 2025 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050924; cv=none; b=O/yZ8Q14n5VwzQ2uTd1VWnbF5doB8024kBlUDoGoI+6NMtzs5XsEdhAcHYU+50N3XLivkq0pcDLFlaCc9kO/bKxXB9WU0cYJLtCe99YRIWXDXG/hpD2aVyc7x8eszkg1fAA3dmugFkURHfGjrs8b0Ff+Yhi3pOy+eaqFEEpz9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050924; c=relaxed/simple;
	bh=Fk5+/tO5dJ3tseH1+u3B9uwF/AZw8i7HDnR5PPUuKZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDuxOGn+VnJ7zvhJwPsL6keMfV4XMZyNhpVwuvTssKafS5qzP7LYGXQBpkuI9uNf4Y6rKlpVDfzV4LHgo+alnN4MzvRRIJ4YOFB9eZHg6d2eTyZx3WXxOxMV3wFJtK9a60Skm2kErH4PjSUs8hUvou3xFbx917CCs3Oo2JBrFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Vw96yu2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2sKQPbqO; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 2E4E11D41520;
	Mon,  3 Mar 2025 20:15:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 20:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1741050921; x=1741054521; bh=Zj
	Cl48tKq3D12A6gMxnuJkwcbixmHB+Hu4Gfto/k5u4=; b=Vw96yu2lEbKBtHSW4C
	3R8c2hfkt0etJT23KMBb85uLvGVRRvWYTJqh0h6RHMWEzvBB6Ut2vbTqwHLIBjz1
	jy0HvxOUFGNDq9XskFSC3eLpll/4Luxf6f8gCRzkJ8/NwvnHCEdFUstBau5e6WX/
	r2N4mqDsWh4gsJGE57yghdaiubR5V6wQgSOJl5ulRa6em5vIMwArGuTJVdRP2nTQ
	VzQmnsQL/ozxeehxoX4b1fJfuLXRN44r850rqmLzuPpI1Rp4J8K7vaXZP1M6X+zE
	MXwJnVtcyZaDaP6f/zzOmssAWAtwluWtxrl2yullNvpFZ0qkcAeYLxKkIa8zP2ZJ
	4q/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741050921; x=1741054521; bh=ZjCl48tKq3D12A6gMxnuJkwcbixm
	HB+Hu4Gfto/k5u4=; b=2sKQPbqODreXvZtoizU1BmAOEdP/aK4nNKSm+1PdfcyC
	Mk/friGK2q6cuVWO9JHMa2JvSmJlLJASilR+6OISLS7W+kJVh+tBoOixhNGE1E1k
	VIgoE1siPEG+IAkSLJ/IufuN4jqc8zNx6S/aU92KL1EVzQKubzRoMAFDvKMWsp5f
	mMc/MV4k3OwA2V7CvoSZp+KjbBUF0RmhEYP2kkKpurTeTRLR49QvEwZBqZXoVz9e
	4pybc397VtzDlkbcKH88C0r47hjZSabnuaSMt9T3Vm4UXVjlAYihZYC02YxT7WqD
	BbCNKr4Vgur/UzkhT3oDcr7XDvlX0rCTosimfU3cJw==
X-ME-Sender: <xms:J1TGZ25cB8B2exJeLYvP78-j5eTTqKkeN3ImtJk6bp7D1AAdAUn9Hg>
    <xme:J1TGZ_5Ki0GoOj02yJae6GA4ebbjmxh7TErpB7oLjveQ2igk7gIGZw7CAvhLnh9vO
    TpGCwzYYPxPV4dRORY>
X-ME-Received: <xmr:J1TGZ1d6N2vBWqFx6ZI0H3wIFiJc7AF8jrfHhw7RBwuba8cbvfYLUkc0T9vb4htQjBKYuuKeUYIyZZO7yPszGnW5WEsF52_SuUcOItJJ53jEzNhYnRxSs8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghouc
    ghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepgeehtdfh
    teetvdegteeggfegueekhfejudetfedtffeikeeuffdtheejffejtdefnecuffhomhgrih
    hnpegthigsvghrshgvtghurhhithihnhgvfihsrdgtohhmpdhgihhthhhusgdrihhonecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgroh
    ifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghkse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphht
    thhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghm
    ihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgvphhnohhpsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:KFTGZzKtoP3dU1MlHGQerNpVR1SbcZisl1Sdd8sawCRVeZAB8aLWcw>
    <xmx:KFTGZ6JuYJsprBSMiZKyhnw752NFWkRCIt60H_XHHuQgfu1jzrni7w>
    <xmx:KFTGZ0xDs8UIRgGGOEwIUjGj64s8-xCbTzeT98wzxn-w3eaT5kKlgw>
    <xmx:KFTGZ-KAd6AcbCrw5XGBwPbIGZNSD08DIkkqhFHHScPMQPifjnIC1w>
    <xmx:KFTGZy-53J2bBM24duFbANFQgYdICs5mdp3ibuPQBWgm2N6qVFvFj_Cp>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:15:18 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive permission requests
Date: Tue,  4 Mar 2025 01:12:56 +0000
Message-ID: <cover.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Landlock supervise: a mechanism for interactive permission requests

Hi,

I would like to propose an extension to Landlock to support a "supervisor"
mode, which would enable a user program to sandbox applications (or
itself) in a dynamic, fine-grained, and potentially temporary way.
Practically, this makes it easy to give maximal control to the user,
perhaps in the form of a "just in time" permission prompt.  Read on, or
check the sandboxer program in the last patch for a "demo".

To Jan Kara and other fanotify reviewers, I've included you in this patch
as Mickaël suggested that we could potentially extend and re-use the
fanotify uapi and code instead of creating an entirely new representation
for permission requests and mechanism for passing it (as this patch
currently does).  I've not really thought out how that would work (there
will probably have to be some extension of the fanotify-fd uapi since
landlock handles more than FS access), but I think it is a promising idea,
hence I would like to hear your thoughts if you could spare a moment to
look at this.  A good outcome could also be that we add the necessary
hooks so that both this and fanotify (but really fsnotify?) can have _perm
events for create/delete/rename etc.

FS mailing list - I've CC'd this patchset to you too - even though the
patch doesn't currently touch any FS code, this is very FS related, and
also, in order to address an inode lock related problem which I will
mention in patch 6 of this series, future versions of this patch will
likely need to add a few more LSM hooks.  Especially for that part, but
also other bits of this project, a pair of eyes from the FS community
would be very helpful.

To Tycho Andersen -- I'm CC'ing you as you've worked on the seccomp-unotify
feature which is also quite related, so if you could spare some time for a
quick review, or provide some suggestions, that would be very appreciated
:)

I'm submitting this series as a non-production-ready, proof-of-concept
RFC, and I would appreciate feedback on any aspects of the design or
implementation.  Note that due to the PoC nature of this, I have not
handled checkpatch.pl errors etc.  I also welcome suggestions for
alternative names for this feature (e.g. landlock-unotify?
landlock-perm?).  At this point I'm very keen to hear some initial
feedback from the community before investing further into polishing this
patch.

(I've briefly pitched the overall idea to Mickaël, but he has not reviewed
the patch yet)


Why extend landlock?
--------------------

While this feature could be implemented as its own LSM, I feel like it is
a natural extension to landlock -- landlock has already defined a set of
fine-grained access requests with the intention to add more (and not just
for FS alone), is designed to be an unprivileged, stackable,
process-scoped, ad-hoc mechanism with no persistent state, which works
well as a generic API to support a dynamic sandbox, and landlock is
already doing the path traversal work to evaluate hierarchical filesystem
rules, which would also be useful for a performant dynamic sandbox
implementation.


Use cases
---------

I have several potential use cases in mind that will benefit from
landlock-supervise, for example:

1. A patch to firejail (I have not discussed with the firejail maintainers
on this yet - wanted to see the reception of this kernel patch first)
which can leverage landlock in a highly flexible way, prompting the user
for permission to access "extra" files after the sandbox has started
(without e.g. having to restart a very stateful GUI program).

This way of using landlock can potentially replace its current approach of
using bind mounts (as it will allow implementing "blacklists"), allowing
unprivileged sandbox creation (although need to check with firejail if
there are other factors preventing this).  This also allows editing
profiles "live" in a highly interactive way (i.e. the user can choose
"allow and remember" on a permission request which will also add the newly
allowed path to a local firejail profile, all automatically)

2. A "protected" mode for common development environments (e.g. VSCode or
a terminal can be launched "protected") that doesn't compromise on
ease-of-use.  File access to $PWD at launch can be allowed, and access to
other places can be allowed ad-hoc by the developer with hopefully one UI
click.  Since landlock can also be used to restrict network access, such a
protected mode can also restrict outgoing connections by default (but ask
the user if they allow it for all or certain processes, on the first
attempt to connect).

Recently there has been incidents of secret-stealing malware targeting
developers (on Linux) by social engineering them to open and build/run a
project. [1]  The hope is that landlock-supervise can drive adoption of
sandboxes for developers and others by making them more user-friendly.

In addition to the above, I also hope that this would help with landlock
adoption even in non-interaction-heavy scenarios, by allowing application
developers the choice to gracefully recover from over-restrictive rulesets
and collect failure metrics, until they are confident that actually
blocking non-allowed accesses would not break their application or degrade
the user experience.

I have more exploration to do regarding applying this to applications, but
I do have a working proof of concept already (implemented as an
enhancement to the sandboxer example). Here is a shortened output:

    bash # env LL_FS_RO=/usr:/lib:/bin:/etc:/dev:/proc LL_FS_RW= LL_SUPERVISE=1 ./sandboxer bash -i
    bash # echo "Hi, $(whoami)!"
    Hi, root!
    bash # ls /
    ------------- Sandboxer access request -------------
    Process ls[166] (/usr/bin/ls) wants to read
      /
    (y)es/(a)lways/(n)o > y
    ----------------------------------------------------
    bin
    boot
    dev
    ...
    usr
    var
    bash # echo 'evil' >> /etc/profile
    (a spurious create request due to current issue with dcache miss is omitted)
    ------------- Sandboxer access request -------------
    Process bash[163] (/usr/bin/bash) wants to read/write
      /etc/profile
    (y)es/(a)lways/(n)o > n
    ----------------------------------------------------
    bash: /etc/profile: Permission denied
    bash #


Alternatives
------------

I have looked for existing ways to implement the proposed use cases (at
least for FS access), and three main approaches stand out to me:

1. Fanotify: there is already FAM_OPEN_PERM which waits for an allow/deny
response from a fanotify listener.  However, it does not currently have
the equivalent _PERM for file creation, deletion, rename and linking, and
it is also not designed for unprivileged, process-scoped use (unlike
landlock).

2. Seccomp-unotify: this can be used to trap all syscalls and give the
sandbox a chance to allow or deny any one of them. However, a correct,
TOCTOU-proof implementation will likely require handling a large number of
fs-related syscalls in user-space, with the sandboxer opening the file or
carrying out the operation on behalf of the sandboxee.  This is probably
going to be extremely complex and makes everything less performant.

3. Using a FUSE filesystem which gates access.  This is actually an
approach taken by an existing sandbox solution - flatpak [2], however it
requires either tight integration with the application (and thus doesn't
work well for the mentioned use cases), or if one wants to sandbox a
program "transparently", SYS_ADMIN to chroot.


I've tested that what I have here works with the enhanced sandboxer, but
have yet to write any self tests or do extensive testing or perf
measurements.  I have also yet to implement support for supervising tcp
rules as well as FS refer operations.

Base commit: 78332fdb956f18accfbca5993b10c5ed69f00a2c (tag:
landlock-6.14-rc5, mic/next)


[1]: https://cybersecuritynews.com/beware-of-lazarus-linkedin-recruiting-scam/
[2]: https://flatpak.github.io/xdg-desktop-portal/docs/documents-and-fuse.html


Tingmao Wang (9):
  Define the supervisor and event structure
  Refactor per-layer information in rulesets and rules
  Adds a supervisor reference in the per-layer information
  User-space API for creating a supervisor-fd
  Define user structure for events and responses.
  Creating supervisor events for filesystem operations
  Implement fdinfo for ruleset and supervisor fd
  Implement fops for supervisor-fd
  Enhance the sandboxer example to support landlock-supervise

 include/uapi/linux/landlock.h | 119 ++++++
 samples/landlock/sandboxer.c  | 759 +++++++++++++++++++++++++++++++++-
 security/landlock/Makefile    |   2 +-
 security/landlock/fs.c        | 134 +++++-
 security/landlock/ruleset.c   |  49 ++-
 security/landlock/ruleset.h   |  66 +--
 security/landlock/supervise.c | 194 +++++++++
 security/landlock/supervise.h | 171 ++++++++
 security/landlock/syscalls.c  | 621 +++++++++++++++++++++++++++-
 9 files changed, 2036 insertions(+), 79 deletions(-)
 create mode 100644 security/landlock/supervise.c
 create mode 100644 security/landlock/supervise.h

--
2.39.5

