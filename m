Return-Path: <linux-fsdevel+bounces-62724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB54B9F3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD887A23C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096E3002B5;
	Thu, 25 Sep 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1HCJO2c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2ILJhG4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dq7eqUBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLWibXDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E82EA483
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803319; cv=none; b=s5M0TMww5M5VA1yI00JtntMT8lyUR/wY7CgYQjHun6OSiLZ4IqWkxlrB0hwhF2BT80Zlcol3X24e/biryVPPXivXfAQqtxQ/EWxH3C1DylskUFyiq5wm17ijJecLLJYbfkpyyT3kEyV98GuixtrQcd8LM5K+k6oWgWKDrQwsv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803319; c=relaxed/simple;
	bh=JeRsezEHn5zcFeSq/jWQFeggeEfF/tbtqyUD25/Xs+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DadZCqPSjxtAJfo7q6++f66dmZD0pB6JRdLHBmQgbGo9j6huP1XXsp16bv7DF7l4lPPua4gfHNwe2MrV4g6gom1VyGzJt2nmd1kMsFQmZPGtwi+hRJUwzXHBPqYegRF6WikPrd7bBGuuAboj5o1vlDtSjoT06n4hkcAJm7tHOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1HCJO2c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2ILJhG4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dq7eqUBS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLWibXDT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 124CA4763;
	Thu, 25 Sep 2025 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758803302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2vGRYwlLLhbEs7i9+mpzMHot51V8Hw97uBwRcluWI=;
	b=v1HCJO2cclXexw3PCrCNUmXECj9hDnB3gqbPGpedUGPuISRzWwiIP9y3rdb5R7q9oUBkLv
	Ip9+z9Pk9pMlHiXlJaHdXbczWFU1ZBM9Cqwg2QJ1Ue9Fc66YfEo8qEcDxaCthQ3l7uvZ5s
	10NmvIiT7ikRZQw3Jh0hjEuR7yGs17k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758803302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2vGRYwlLLhbEs7i9+mpzMHot51V8Hw97uBwRcluWI=;
	b=J2ILJhG413tPjl9rSAzeV6IF09dKfjfVc5CwlzFTI79ekQZ1iZkVAlaGfQi9qpI39jDh45
	Nvsnet5Xy5CvkkAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dq7eqUBS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hLWibXDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758803301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2vGRYwlLLhbEs7i9+mpzMHot51V8Hw97uBwRcluWI=;
	b=Dq7eqUBShNK/Z98Wc6YGe1h9Gb8l1QH1EO2axgRm0SeXRy8a2f1GFhVRGzPatW+t4+qWwU
	cfqv9KJhOUiLD8PslPQyLffce+w261o/UsFpjhdTsrs8OGnqaFOLNFuS5lrTOswjTzsjkG
	6gpJOt9nVOdAJZ9nUAiCwNLUgdQ2FlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758803301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2vGRYwlLLhbEs7i9+mpzMHot51V8Hw97uBwRcluWI=;
	b=hLWibXDTQUB6Rj+2Y8mm1nQvGW3mKbMrEgLbJ5f1VFcPcV3pY6ArwyOaBgrwDZRQbRjZ49
	Me/uw4Y7jfulvfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F35E5132C9;
	Thu, 25 Sep 2025 12:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hAVnO2Q11WhGGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 12:28:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1A62A0AA0; Thu, 25 Sep 2025 14:28:16 +0200 (CEST)
Date: Thu, 25 Sep 2025 14:28:16 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, John Johansen <john@apparmor.net>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 124CA4763
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,suse.cz,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

Thanks for report Mark!

On Thu 25-09-25 12:40:02, Mark Brown wrote:
> On Sat, Sep 06, 2025 at 10:13:39AM +0100, Al Viro wrote:
> > [first commit in work.f_path]
> >=20
> > 	Instead of switching ->f_path.mnt of an opened file to internal
> > clone, resolve the pathname, get a struct path with ->mnt set to intern=
al
> > clone, then dentry_open() that to get the file with right ->f_path.mnt
> > from the very beginning.
>=20
> I'm seeing test failures in -next on the LTP acct01 test which bisect to
> this patch.  The test fails with:
>=20
> acct01.c:123: TFAIL: acct(.) expected EISDIR: EACCES (13)

This is mostly harmless (just the returned error code changed) but it is a
side effect of one thing I'd like to discuss: The original code uses
file_open_name(O_WRONLY|O_APPEND|O_LARGEFILE) to open the file to write
data to. The new code uses dentry_open() for that. Now one important
difference between these two is that dentry_open() doesn't end up calling
may_open() on the path and hence now acct_on() fails to check file
permissions which looks like a bug? Am I missing something Al?

								Honza

> acct01.c:123: TPASS: acct(/dev/null) : EACCES (13)
> acct01.c:123: TPASS: acct(/tmp/does/not/exist) : ENOENT (2)
> acct01.c:123: TPASS: acct(./tmpfile/) : ENOTDIR (20)
> acct01.c:123: TPASS: acct(./tmpfile) : EPERM (1)
> acct01.c:123: TPASS: acct(NULL) : EPERM (1)
> acct01.c:123: TPASS: acct(test_file_eloop1) : ELOOP (40)
> acct01.c:123: TPASS: acct(aaaa...) : ENAMETOOLONG (36)
> acct01.c:123: TPASS: acct(ro_mntpoint/file) : EROFS (30)
> acct01.c:123: TPASS: acct(Invalid address) : EFAULT (14)
> Summary:
> passed   9
> failed   1
> broken   0
> skipped  0
> warnings 0
>=20
> Full log:
>=20
>    https://lava.sirena.org.uk/scheduler/job/1882210#L7052
>=20
> Bisect log with links to more test runs, it looks like the bisect got
> very lucky and tested this patch first for some reason:
>=20
> # bad: [b5a4da2c459f79a2c87c867398f1c0c315779781] Add linux-next specific=
 files for 20250924
> # good: [69ed2a71d8f82f4304aa52c2c4abf41d1c1f4c7e] Merge branch 'for-linu=
x-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> # good: [e609438851928381e39b5393f17156955a84122a] regulator: dt-bindings=
: qcom,sdm845-refgen-regulator: document more platforms
> # good: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] regulator: dt-bindings=
: qcom,sdm845-refgen-regulator: document more platforms
> # good: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] SPI: Add virtio SPI dr=
iver
> # good: [ad4728740bd68d74365a43acc25a65339a9b2173] spi: rpc-if: Add resum=
e support for RZ/G3E
> # good: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] tas2783A: Add acpi mat=
ch changes for Intel MTL
> # good: [46c8b4d2a693eca69a2191436cffa44f489e98c7] ASoC: cs35l41: Fallbac=
k to reading Subsystem ID property if not ACPI
> # good: [e336ab509b43ea601801dfa05b4270023c3ed007] spi: rename SPI_CS_CNT=
_MAX =3D> SPI_DEVICE_CS_CNT_MAX
> # good: [878702702dbbd933a5da601c75b8e58eadeec311] spi: ljca: Remove Went=
ong's e-mail address
> # good: [20253f806818e9a1657a832ebcf4141d0a08c02a] spi: atmel-quadspi: Ad=
d support for sama7d65 QSPI
> # good: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] ASoC: da7213: Convert =
to DEFINE_RUNTIME_DEV_PM_OPS()
> # good: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] ASoC: soc-dapm: add sn=
d_soc_dapm_set_idle_bias()
> # good: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] ASoC: fsl: fsl_qmc_aud=
io: Drop struct qmc_dai_chan
> # good: [0f67557763accbdd56681f17ed5350735198c57b] spi: spi-nxp-fspi: Add=
 OCT-DTR mode support
> # good: [0266f9541038b9b98ddd387132b5bdfe32a304e3] ASoC: codecs: wcd937x:=
 get regmap directly
> # good: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] spi: spi-qpic-snand: s=
implify clock handling by using devm_clk_get_enabled()
> # good: [abe962346ef420998d47ba1c2fe591582f69e92e] regulator: Fix MAX7783=
8 selection
> # good: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] spi: mt65xx: add dual =
and quad mode for standard spi device
> # good: [88d0d17192c5a850dc07bb38035b69c4cefde270] ASoC: dt-bindings: add=
 bindings for pm4125 audio codec
> # good: [8b84d712ad849172f6bbcad57534b284d942b0b5] regulator: spacemit: s=
upport SpacemiT P1 regulators
> # good: [8d7de4a014f589c1776959f7fdadbf7b12045aac] ASoC: dt-bindings: asa=
hi-kasei,ak4458: Reference common DAI properties
> # good: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] regulator: max77838: a=
dd max77838 regulator driver
> # good: [4d906371d1f9fc9ce47b2c8f37444680246557bc] nsfs: drop tautologica=
l ioctl() check
> # good: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] nsfs: validate extensi=
ble ioctls
> # good: [8b184c34806e5da4d4847fabd3faeff38b47e70a] ASoC: Intel: hda-sdw-b=
pt: set persistent_buffer false
> # good: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] spi: amlogic: Fix erro=
r checking on regmap_write call
> # good: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] ASoC: codecs: pcm1754:=
 add pcm1754 dac driver
> # good: [59ba108806516adeaed51a536d55d4f5e9645881] ASoC: dt-bindings: lin=
ux,spdif: Add "port" node
> # good: [30db1b21fa37a2f37c7f4d71864405a05e889833] spi: axi-spi-engine: u=
se adi_axi_pcore_ver_gteq()
> # good: [2e0fd4583d0efcdc260e61a22666c8368f505353] rust: regulator: add d=
evm_enable and devm_enable_optional
> # good: [6a129b2ca5c533aec89fbeb58470811cc4102642] MAINTAINERS: Add an en=
try for Amlogic spifc driver
> # good: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] spi: cadence-quadspi: =
Use BIT() macros where possible
> # good: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] ASoC: cs-amp-lib-test:=
 Add test for getting cal data from HP EFI
> # good: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] ASoC: codecs: tlv320da=
c33: Convert to use gpiod api
> # good: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] regulator: dt-bindings=
: rpi-panel: Split 7" Raspberry Pi 720x1280 v2 binding
> # good: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] ASoC: Intel: bytcr_rt5=
651: Fix invalid quirk input mapping
> # good: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] spi: dt-bindings: sams=
ung: Drop S3C2443
> # good: [7d083666123a425ba9f81dff1a52955b1f226540] ASoC: renesas: rz-ssi:=
 Use guard() for spin locks
> # good: [b497e1a1a2b10c4ddb28064fba229365ae03311a] regulator: pf530x: Add=
 a driver for the NXP PF5300 Regulator
> # good: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] ASoC: replace use of s=
ystem_unbound_wq with system_dfl_wq
> # good: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] ASoC: dt-bindings: wlf=
,wm8960: Document routing strings (pin names)
> # good: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] ASoC: dt-bindings: qco=
m,lpass-va-macro: Update bindings for clocks to support ADSP
> # good: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] ASoC: cs42l43: Shutdow=
n jack detection on suspend
> # good: [94b39cb3ad6db935b585988b36378884199cd5fc] spi: mxs: fix "transfe=
red"->"transferred"
> # good: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] spi: spi-fsl-dspi: Rep=
ort FIFO overflows as errors
> # good: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] ASoC: codecs: lpass-ws=
a-macro: add Codev version 2.9
> # good: [06dd3eda0e958cdae48ca755eb5047484f678d78] Merge branch 'vfs-6.18=
=2Erust' into vfs.all
> # good: [ce57b718006a069226b5e5d3afe7969acd59154e] ASoC: Intel: avs: ssm4=
567: Adjust platform name
> # good: [3279052eab235bfb7130b1fabc74029c2260ed8d] ASoC: SOF: ipc4-topolo=
gy: Fix a less than zero check on a u32
> # good: [6d33ce3634f99e0c6c9ce9fc111261f2c411cb48] selftests/nolibc: fix =
EXPECT_NZ macro
> # good: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] ASoC: qcom: audioreach=
: convert to cpu endainess type before accessing
> # good: [9d35d068fb138160709e04e3ee97fe29a6f8615b] regulator: scmi: Use i=
nt type to store negative error codes
> # good: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] ASoC: soc-dapm: rename=
 snd_soc_kcontrol_component() to snd_soc_kcontrol_to_component()
> # good: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] ASoC: sof: ipc4-topolo=
gy: Add support to sched_domain attribute
> # good: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] ASoC: SOF: Intel: only=
 detect codecs when HDA DSP probe
> # good: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] ASoC: SOF: sof-client:=
 Introduce sof_client_dev_entry structure
> # good: [f7c41911ad744177d8289820f01009dc93d8f91c] ASoC: SOF: ipc4-topolo=
gy: Add support for float sample type
> # good: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] ASoC: doc: Internally =
link to Writing an ALSA Driver docs
> # good: [d57d27171c92e9049d5301785fb38de127b28fbf] ASoC: SOF: sof-client-=
probes: Add available points_info(), IPC4 only
> # good: [a37280daa4d583c7212681c49b285de9464a5200] ASoC: Intel: avs: Allo=
w i2s test and non-test boards to coexist
> # good: [b088b6189a4066b97cef459afd312fd168a76dea] ASoC: mediatek: common=
: Switch to for_each_available_child_of_node_scoped()
> # good: [c42e36a488c7e01f833fc9f4814f735b66b2d494] spi: Drop dev_pm_domai=
n_detach() call
> # good: [ff9a7857b7848227788f113d6dc6a72e989084e0] spi: rb4xx: use devm f=
or clk_prepare_enable
> # good: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] regmap: use int type t=
o store negative error codes
> # good: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] ASoC: renesas: msiof: =
start DMAC first
> # good: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] Merge branch 'next/dri=
vers' into for-next
> # good: [11f5c5f9e43e9020bae452232983fe98e7abfce0] ASoC: qcom: use int ty=
pe to store negative error codes
> # good: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] regulator: core: Remov=
e redundant ternary operators
> # good: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] ASoC: amd: acp: Remove=
 (explicitly) unused header
> # good: [e2ab5f600bb01d3625d667d97b3eb7538e388336] rust: regulator: use `=
to_result` for error handling
> # good: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] ASoC: tlv320aic32x4: u=
se dev_err_probe() for regulators
> # good: [f840737d1746398c2993be34bfdc80bdc19ecae2] ASoC: SOF: imx: Remove=
 the use of dev_err_probe()
> # good: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] ASoC: dt-bindings: Min=
or whitespace cleanup in example
> # good: [136d029662cdde77d3e4db5c07de655f35f0239f] Documentation/staging:=
 Fix typo and incorrect citation in crc32.rst
> # good: [96bcb34df55f7fee99795127c796315950c94fed] ASoC: test-component: =
Use kcalloc() instead of kzalloc()
> # good: [c232495d28ca092d0c39b10e35d3d613bd2414ab] ASoC: dt-bindings: oma=
p-twl4030: convert to DT schema
> # good: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] regulator: consumer.rs=
t: document bulk operations
> # good: [27848c082ba0b22850fd9fb7b185c015423dcdc7] spi: s3c64xx: Remove t=
he use of dev_err_probe()
> # good: [c1dd310f1d76b4b13f1854618087af2513140897] spi: SPISG: Use devm_k=
calloc() in aml_spisg_clk_init()
> # good: [da9881d00153cc6d3917f6b74144b1d41b58338c] ASoC: qcom: audioreach=
: add support for SMECNS module
> # good: [cf65182247761f7993737b710afe8c781699356b] ASoC: codecs: wsa883x:=
 Handle shared reset GPIO for WSA883x speakers
> # good: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] regulator: bd718x7: Us=
e kcalloc() instead of kzalloc()
> # good: [2a55135201d5e24b80b7624880ff42eafd8e320c] ASoC: Intel: avs: Stre=
amline register-component function names
> # good: [daf855f76a1210ceed9541f71ac5dd9be02018a6] ASoC: es8323: enable D=
APM power widgets for playback DAC
> # good: [0056b410355713556d8a10306f82e55b28d33ba8] spi: offload trigger: =
adi-util-sigma-delta: clean up imports
> # good: [90179609efa421b1ccc7d8eafbc078bafb25777c] spi: spl022: use min_t=
() to improve code
> # good: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] ASoC: es8323: enable D=
APM power widgets for playback DAC and output
> # good: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] spi: remove unneeded '=
fast_io' parameter in regmap_config
> # good: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] regulator: rt5133: Fix=
 spelling mistake "regualtor" -> "regulator"
> # good: [0e62438e476494a1891a8822b9785bc6e73e9c3f] ASoC: Intel: sst: Remo=
ve redundant semicolons
> # good: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] regulator: remove unne=
eded 'fast_io' parameter in regmap_config
> # good: [a46e95c81e3a28926ab1904d9f754fef8318074d] ASoC: wl1273: Remove
> # good: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] regmap: Remove superfl=
uous check for !config in __regmap_init()
> # good: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] regulator: rt5133: Add=
 RT5133 PMIC regulator Support
> # good: [9c45f95222beecd6a284fd1284d54dd7a772cf59] spi: spi-qpic-snand: h=
andle 'use_ecc' parameter of qcom_spi_config_cw_read()
> # good: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] ASoC: dt-bindings: Con=
vert brcm,bcm2835-i2s to DT schema
> # good: [b832b19318534bb4f1673b24d78037fee339c679] spi: loopback-test: Do=
n't use %pK through printk
> # good: [8c02c8353460f8630313aef6810f34e134a3c1ee] ASoC: dt-bindings: rea=
ltek,alc5623: convert to DT schema
> # good: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] spi: spi-qpic-snand: r=
emove 'clr*status' members of struct 'qpic_ecc'
> # good: [a54ef14188519a0994d0264f701f5771815fa11e] regulator: dt-bindings=
: Clean-up active-semi,act8945a duplication
> # good: [2291a2186305faaf8525d57849d8ba12ad63f5e7] MAINTAINERS: Add entry=
 for FourSemi audio amplifiers
> # good: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] ASoC: soc-component: u=
npack snd_soc_component_init_bias_level()
> # good: [595b7f155b926460a00776cc581e4dcd01220006] ASoC: Intel: avs: Cond=
itional-path support
> # good: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] spi: spi-qpic-snand: a=
void double assignment in qcom_spi_probe()
> # good: [3059067fd3378a5454e7928c08d20bf3ef186760] ASoC: cs48l32: Use PTR=
_ERR_OR_ZERO() to simplify code
> # good: [9a200cbdb54349909a42b45379e792e4b39dd223] rust: regulator: imple=
ment Send and Sync for Regulator<T>
> # good: [2d86d2585ab929a143d1e6f8963da1499e33bf13] ASoC: pxa: add GPIOLIB=
_LEGACY dependency
> # good: [162e23657e5379f07c6404dbfbf4367cb438ea7d] regulator: pf0900: Add=
 PMIC PF0900 support
> # good: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] regmap: mmio: Add miss=
ing MODULE_DESCRIPTION()
> git bisect start 'b5a4da2c459f79a2c87c867398f1c0c315779781' '69ed2a71d8f8=
2f4304aa52c2c4abf41d1c1f4c7e' 'e609438851928381e39b5393f17156955a84122a' '5=
fa7d739f811bdffb5fc99696c2e821344fe0b88' 'f98cabe3f6cf6396b3ae0264800d9b53d=
7612433' 'ad4728740bd68d74365a43acc25a65339a9b2173' '63b4c34635cf32af023796=
b64c855dd1ed0f0a4f' '46c8b4d2a693eca69a2191436cffa44f489e98c7' 'e336ab509b4=
3ea601801dfa05b4270023c3ed007' '878702702dbbd933a5da601c75b8e58eadeec311' '=
20253f806818e9a1657a832ebcf4141d0a08c02a' '2aa28b748fc967a2f2566c06bdad155f=
ba8af7d8' 'cb3c715d89607f8896c0f20fe528a08e7ebffea9' '2c618f361ae6b9da7fafa=
fc289051728ef4c6ea3' '0f67557763accbdd56681f17ed5350735198c57b' '0266f95410=
38b9b98ddd387132b5bdfe32a304e3' 'a24802b0a2a238eaa610b0b0e87a4500a35de64a' =
'abe962346ef420998d47ba1c2fe591582f69e92e' 'ab63e9910d2d3ea4b8e6c08812258a6=
76defcb9c' '88d0d17192c5a850dc07bb38035b69c4cefde270' '8b84d712ad849172f6bb=
cad57534b284d942b0b5' '8d7de4a014f589c1776959f7fdadbf7b12045aac' '6a1f303cb=
a45fa3b612d5a2898b1b1b045eb74e3' '4d906371d1f9fc9ce47b2c8f37444680246557bc'=
 'f8527a29f4619f74bc30a9845ea87abb9a6faa1e' '8b184c34806e5da4d4847fabd3faef=
f38b47e70a' '18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4' '1217b573978482ae7d2=
1dc5c0bf5aa5007b24f90' '59ba108806516adeaed51a536d55d4f5e9645881' '30db1b21=
fa37a2f37c7f4d71864405a05e889833' '2e0fd4583d0efcdc260e61a22666c8368f505353=
' '6a129b2ca5c533aec89fbeb58470811cc4102642' 'd9e33b38c89f4cf8c32b8481dbcf3=
a6cdbba4595' 'e5b4ad2183f7ab18aaf7c73a120d17241ee58e97' '1cf87861a2e02432fb=
68f8bcc8f20a8e42acde59' '5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5' '4336efb=
59ef364e691ef829a73d9dbd4d5ed7c7b' '2c625f0fe2db4e6a58877ce2318df3aa312eb79=
1' '7d083666123a425ba9f81dff1a52955b1f226540' 'b497e1a1a2b10c4ddb28064fba22=
9365ae03311a' '9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634' '0ccc1eeda155c947d=
88ef053e0b54e434e218ee2' '7748328c2fd82efed24257b2bfd796eb1fa1d09b' 'dd7ae5=
b8b3c291c0206f127a564ae1e316705ca0' '94b39cb3ad6db935b585988b36378884199cd5=
fc' '5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd' 'ce1a46b2d6a8465a86f7a6f71be=
b4c6de83bce5c' '06dd3eda0e958cdae48ca755eb5047484f678d78' 'ce57b718006a0692=
26b5e5d3afe7969acd59154e' '3279052eab235bfb7130b1fabc74029c2260ed8d' '6d33c=
e3634f99e0c6c9ce9fc111261f2c411cb48' '8f57dcf39fd0864f5f3e6701fe885e55f45d0=
d3a' '9d35d068fb138160709e04e3ee97fe29a6f8615b' '8a9772ec08f87c9e45ab1ad2c8=
d2b8c1763836eb' '3d439e1ec3368fae17db379354bd7a9e568ca0ab' '5c39bc498f5ff7e=
f016abf3f16698f3e8db79677' '07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9' 'f7c4=
1911ad744177d8289820f01009dc93d8f91c' 'f522da9ab56c96db8703b2ea0f09be7cdc3b=
ffeb' 'd57d27171c92e9049d5301785fb38de127b28fbf' 'a37280daa4d583c7212681c49=
b285de9464a5200' 'b088b6189a4066b97cef459afd312fd168a76dea' 'c42e36a488c7e0=
1f833fc9f4814f735b66b2d494' 'ff9a7857b7848227788f113d6dc6a72e989084e0' 'f46=
72dc6e9c07643c8c755856ba8e9eb9ca95d0c' 'edb5c1f885207d1d74e8a1528e6937e0282=
9ee6e' '6c177775dcc5e70a64ddf4ee842c66af498f2c7c' '11f5c5f9e43e9020bae45223=
2983fe98e7abfce0' '899fb38dd76dd3ede425bbaf8a96d390180a5d1c' '5b4dcaf851df8=
c414bfc2ac3bf9c65fc942f3be4' 'e2ab5f600bb01d3625d667d97b3eb7538e388336' 'a1=
2b74d2bd4724ee1883bc97ec93eac8fafc8d3c' 'f840737d1746398c2993be34bfdc80bdc1=
9ecae2' 'd78e48ebe04e9566f8ecbf51471e80da3adbceeb' '136d029662cdde77d3e4db5=
c07de655f35f0239f' '96bcb34df55f7fee99795127c796315950c94fed' 'c232495d28ca=
092d0c39b10e35d3d613bd2414ab' 'ec0be3cdf40b5302248f3fb27a911cc630e8b855' '2=
7848c082ba0b22850fd9fb7b185c015423dcdc7' 'c1dd310f1d76b4b13f1854618087af251=
3140897' 'da9881d00153cc6d3917f6b74144b1d41b58338c' 'cf65182247761f7993737b=
710afe8c781699356b' '550bc517e59347b3b1af7d290eac4fb1411a3d4e' '2a55135201d=
5e24b80b7624880ff42eafd8e320c' 'daf855f76a1210ceed9541f71ac5dd9be02018a6' '=
0056b410355713556d8a10306f82e55b28d33ba8' '90179609efa421b1ccc7d8eafbc078ba=
fb25777c' '258384d8ce365dddd6c5c15204de8ccd53a7ab0a' '48124569bbc6bfda1df3e=
9ee17b19d559f4b1aa3' '6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d' '0e62438e47=
6494a1891a8822b9785bc6e73e9c3f' '37533933bfe92cd5a99ef4743f31dac62ccc8de0' =
'a46e95c81e3a28926ab1904d9f754fef8318074d' '5c36b86d2bf68fbcad16169983ef7ee=
8c537db59' '714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb' '9c45f95222beecd6a284=
fd1284d54dd7a772cf59' 'bab4ab484a6ca170847da9bffe86f1fa90df4bbe' 'b832b1931=
8534bb4f1673b24d78037fee339c679' '8c02c8353460f8630313aef6810f34e134a3c1ee'=
 '6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1' 'a54ef14188519a0994d0264f701f57=
71815fa11e' '2291a2186305faaf8525d57849d8ba12ad63f5e7' 'cf25eb8eae91bcae9b2=
065d84b0c0ba0f6d9dd34' '595b7f155b926460a00776cc581e4dcd01220006' 'a1d0b0ae=
65ae3f32597edfbb547f16c75601cd87' '3059067fd3378a5454e7928c08d20bf3ef186760=
' '9a200cbdb54349909a42b45379e792e4b39dd223' '2d86d2585ab929a143d1e6f8963da=
1499e33bf13' '162e23657e5379f07c6404dbfbf4367cb438ea7d' '886f42ce96e7ce8054=
5704e7168a9c6b60cd6c03'
> # test job: [e609438851928381e39b5393f17156955a84122a] https://lava.siren=
a.org.uk/scheduler/job/1868301
> # test job: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] https://lava.siren=
a.org.uk/scheduler/job/1868351
> # test job: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] https://lava.siren=
a.org.uk/scheduler/job/1862378
> # test job: [ad4728740bd68d74365a43acc25a65339a9b2173] https://lava.siren=
a.org.uk/scheduler/job/1862571
> # test job: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] https://lava.siren=
a.org.uk/scheduler/job/1863569
> # test job: [46c8b4d2a693eca69a2191436cffa44f489e98c7] https://lava.siren=
a.org.uk/scheduler/job/1862012
> # test job: [e336ab509b43ea601801dfa05b4270023c3ed007] https://lava.siren=
a.org.uk/scheduler/job/1862870
> # test job: [878702702dbbd933a5da601c75b8e58eadeec311] https://lava.siren=
a.org.uk/scheduler/job/1863783
> # test job: [20253f806818e9a1657a832ebcf4141d0a08c02a] https://lava.siren=
a.org.uk/scheduler/job/1848487
> # test job: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] https://lava.siren=
a.org.uk/scheduler/job/1848316
> # test job: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] https://lava.siren=
a.org.uk/scheduler/job/1847531
> # test job: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] https://lava.siren=
a.org.uk/scheduler/job/1850256
> # test job: [0f67557763accbdd56681f17ed5350735198c57b] https://lava.siren=
a.org.uk/scheduler/job/1848730
> # test job: [0266f9541038b9b98ddd387132b5bdfe32a304e3] https://lava.siren=
a.org.uk/scheduler/job/1848825
> # test job: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] https://lava.siren=
a.org.uk/scheduler/job/1847698
> # test job: [abe962346ef420998d47ba1c2fe591582f69e92e] https://lava.siren=
a.org.uk/scheduler/job/1840610
> # test job: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] https://lava.siren=
a.org.uk/scheduler/job/1838203
> # test job: [88d0d17192c5a850dc07bb38035b69c4cefde270] https://lava.siren=
a.org.uk/scheduler/job/1834007
> # test job: [8b84d712ad849172f6bbcad57534b284d942b0b5] https://lava.siren=
a.org.uk/scheduler/job/1834035
> # test job: [8d7de4a014f589c1776959f7fdadbf7b12045aac] https://lava.siren=
a.org.uk/scheduler/job/1833177
> # test job: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] https://lava.siren=
a.org.uk/scheduler/job/1830452
> # test job: [4d906371d1f9fc9ce47b2c8f37444680246557bc] https://lava.siren=
a.org.uk/scheduler/job/1832437
> # test job: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] https://lava.siren=
a.org.uk/scheduler/job/1832501
> # test job: [8b184c34806e5da4d4847fabd3faeff38b47e70a] https://lava.siren=
a.org.uk/scheduler/job/1829208
> # test job: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] https://lava.siren=
a.org.uk/scheduler/job/1829126
> # test job: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] https://lava.siren=
a.org.uk/scheduler/job/1809935
> # test job: [59ba108806516adeaed51a536d55d4f5e9645881] https://lava.siren=
a.org.uk/scheduler/job/1812752
> # test job: [30db1b21fa37a2f37c7f4d71864405a05e889833] https://lava.siren=
a.org.uk/scheduler/job/1811000
> # test job: [2e0fd4583d0efcdc260e61a22666c8368f505353] https://lava.siren=
a.org.uk/scheduler/job/1806799
> # test job: [6a129b2ca5c533aec89fbeb58470811cc4102642] https://lava.siren=
a.org.uk/scheduler/job/1805795
> # test job: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] https://lava.siren=
a.org.uk/scheduler/job/1800095
> # test job: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] https://lava.siren=
a.org.uk/scheduler/job/1799490
> # test job: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] https://lava.siren=
a.org.uk/scheduler/job/1795075
> # test job: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] https://lava.siren=
a.org.uk/scheduler/job/1795939
> # test job: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] https://lava.siren=
a.org.uk/scheduler/job/1795892
> # test job: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] https://lava.siren=
a.org.uk/scheduler/job/1794526
> # test job: [7d083666123a425ba9f81dff1a52955b1f226540] https://lava.siren=
a.org.uk/scheduler/job/1794861
> # test job: [b497e1a1a2b10c4ddb28064fba229365ae03311a] https://lava.siren=
a.org.uk/scheduler/job/1780204
> # test job: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] https://lava.siren=
a.org.uk/scheduler/job/1779465
> # test job: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] https://lava.siren=
a.org.uk/scheduler/job/1773032
> # test job: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] https://lava.siren=
a.org.uk/scheduler/job/1773343
> # test job: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] https://lava.siren=
a.org.uk/scheduler/job/1773264
> # test job: [94b39cb3ad6db935b585988b36378884199cd5fc] https://lava.siren=
a.org.uk/scheduler/job/1768594
> # test job: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] https://lava.siren=
a.org.uk/scheduler/job/1769303
> # test job: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] https://lava.siren=
a.org.uk/scheduler/job/1768977
> # test job: [06dd3eda0e958cdae48ca755eb5047484f678d78] https://lava.siren=
a.org.uk/scheduler/job/1832025
> # test job: [ce57b718006a069226b5e5d3afe7969acd59154e] https://lava.siren=
a.org.uk/scheduler/job/1768708
> # test job: [3279052eab235bfb7130b1fabc74029c2260ed8d] https://lava.siren=
a.org.uk/scheduler/job/1762443
> # test job: [6d33ce3634f99e0c6c9ce9fc111261f2c411cb48] https://lava.siren=
a.org.uk/scheduler/job/1780072
> # test job: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] https://lava.siren=
a.org.uk/scheduler/job/1760110
> # test job: [9d35d068fb138160709e04e3ee97fe29a6f8615b] https://lava.siren=
a.org.uk/scheduler/job/1758669
> # test job: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] https://lava.siren=
a.org.uk/scheduler/job/1758549
> # test job: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] https://lava.siren=
a.org.uk/scheduler/job/1753438
> # test job: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] https://lava.siren=
a.org.uk/scheduler/job/1752464
> # test job: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] https://lava.siren=
a.org.uk/scheduler/job/1752286
> # test job: [f7c41911ad744177d8289820f01009dc93d8f91c] https://lava.siren=
a.org.uk/scheduler/job/1752277
> # test job: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] https://lava.siren=
a.org.uk/scheduler/job/1751873
> # test job: [d57d27171c92e9049d5301785fb38de127b28fbf] https://lava.siren=
a.org.uk/scheduler/job/1752634
> # test job: [a37280daa4d583c7212681c49b285de9464a5200] https://lava.siren=
a.org.uk/scheduler/job/1746884
> # test job: [b088b6189a4066b97cef459afd312fd168a76dea] https://lava.siren=
a.org.uk/scheduler/job/1746221
> # test job: [c42e36a488c7e01f833fc9f4814f735b66b2d494] https://lava.siren=
a.org.uk/scheduler/job/1746231
> # test job: [ff9a7857b7848227788f113d6dc6a72e989084e0] https://lava.siren=
a.org.uk/scheduler/job/1746324
> # test job: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] https://lava.siren=
a.org.uk/scheduler/job/1747874
> # test job: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] https://lava.siren=
a.org.uk/scheduler/job/1746145
> # test job: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] https://lava.siren=
a.org.uk/scheduler/job/1780443
> # test job: [11f5c5f9e43e9020bae452232983fe98e7abfce0] https://lava.siren=
a.org.uk/scheduler/job/1747495
> # test job: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] https://lava.siren=
a.org.uk/scheduler/job/1747371
> # test job: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] https://lava.siren=
a.org.uk/scheduler/job/1747664
> # test job: [e2ab5f600bb01d3625d667d97b3eb7538e388336] https://lava.siren=
a.org.uk/scheduler/job/1746572
> # test job: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] https://lava.siren=
a.org.uk/scheduler/job/1734064
> # test job: [f840737d1746398c2993be34bfdc80bdc19ecae2] https://lava.siren=
a.org.uk/scheduler/job/1727349
> # test job: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] https://lava.siren=
a.org.uk/scheduler/job/1706173
> # test job: [136d029662cdde77d3e4db5c07de655f35f0239f] https://lava.siren=
a.org.uk/scheduler/job/1780406
> # test job: [96bcb34df55f7fee99795127c796315950c94fed] https://lava.siren=
a.org.uk/scheduler/job/1699603
> # test job: [c232495d28ca092d0c39b10e35d3d613bd2414ab] https://lava.siren=
a.org.uk/scheduler/job/1699550
> # test job: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] https://lava.siren=
a.org.uk/scheduler/job/1694311
> # test job: [27848c082ba0b22850fd9fb7b185c015423dcdc7] https://lava.siren=
a.org.uk/scheduler/job/1693098
> # test job: [c1dd310f1d76b4b13f1854618087af2513140897] https://lava.siren=
a.org.uk/scheduler/job/1692990
> # test job: [da9881d00153cc6d3917f6b74144b1d41b58338c] https://lava.siren=
a.org.uk/scheduler/job/1693415
> # test job: [cf65182247761f7993737b710afe8c781699356b] https://lava.siren=
a.org.uk/scheduler/job/1687536
> # test job: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] https://lava.siren=
a.org.uk/scheduler/job/1685913
> # test job: [2a55135201d5e24b80b7624880ff42eafd8e320c] https://lava.siren=
a.org.uk/scheduler/job/1685775
> # test job: [daf855f76a1210ceed9541f71ac5dd9be02018a6] https://lava.siren=
a.org.uk/scheduler/job/1685463
> # test job: [0056b410355713556d8a10306f82e55b28d33ba8] https://lava.siren=
a.org.uk/scheduler/job/1685632
> # test job: [90179609efa421b1ccc7d8eafbc078bafb25777c] https://lava.siren=
a.org.uk/scheduler/job/1686082
> # test job: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] https://lava.siren=
a.org.uk/scheduler/job/1673404
> # test job: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] https://lava.siren=
a.org.uk/scheduler/job/1670194
> # test job: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] https://lava.siren=
a.org.uk/scheduler/job/1673155
> # test job: [0e62438e476494a1891a8822b9785bc6e73e9c3f] https://lava.siren=
a.org.uk/scheduler/job/1669533
> # test job: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] https://lava.siren=
a.org.uk/scheduler/job/1668976
> # test job: [a46e95c81e3a28926ab1904d9f754fef8318074d] https://lava.siren=
a.org.uk/scheduler/job/1673737
> # test job: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] https://lava.siren=
a.org.uk/scheduler/job/1667939
> # test job: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] https://lava.siren=
a.org.uk/scheduler/job/1667687
> # test job: [9c45f95222beecd6a284fd1284d54dd7a772cf59] https://lava.siren=
a.org.uk/scheduler/job/1667605
> # test job: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] https://lava.siren=
a.org.uk/scheduler/job/1664696
> # test job: [b832b19318534bb4f1673b24d78037fee339c679] https://lava.siren=
a.org.uk/scheduler/job/1659192
> # test job: [8c02c8353460f8630313aef6810f34e134a3c1ee] https://lava.siren=
a.org.uk/scheduler/job/1659256
> # test job: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] https://lava.siren=
a.org.uk/scheduler/job/1656575
> # test job: [a54ef14188519a0994d0264f701f5771815fa11e] https://lava.siren=
a.org.uk/scheduler/job/1656016
> # test job: [2291a2186305faaf8525d57849d8ba12ad63f5e7] https://lava.siren=
a.org.uk/scheduler/job/1655762
> # test job: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] https://lava.siren=
a.org.uk/scheduler/job/1654786
> # test job: [595b7f155b926460a00776cc581e4dcd01220006] https://lava.siren=
a.org.uk/scheduler/job/1653153
> # test job: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] https://lava.siren=
a.org.uk/scheduler/job/1654229
> # test job: [3059067fd3378a5454e7928c08d20bf3ef186760] https://lava.siren=
a.org.uk/scheduler/job/1654000
> # test job: [9a200cbdb54349909a42b45379e792e4b39dd223] https://lava.siren=
a.org.uk/scheduler/job/1654755
> # test job: [2d86d2585ab929a143d1e6f8963da1499e33bf13] https://lava.siren=
a.org.uk/scheduler/job/1654130
> # test job: [162e23657e5379f07c6404dbfbf4367cb438ea7d] https://lava.siren=
a.org.uk/scheduler/job/1652972
> # test job: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] https://lava.siren=
a.org.uk/scheduler/job/1654301
> # test job: [b5a4da2c459f79a2c87c867398f1c0c315779781] https://lava.siren=
a.org.uk/scheduler/job/1882210
> # bad: [b5a4da2c459f79a2c87c867398f1c0c315779781] Add linux-next specific=
 files for 20250924
> git bisect bad b5a4da2c459f79a2c87c867398f1c0c315779781
> # test job: [ccc54b556054d20a1e04eac48200e63e6b87fe1c] https://lava.siren=
a.org.uk/scheduler/job/1818582
> # bad: [ccc54b556054d20a1e04eac48200e63e6b87fe1c] kernel/acct.c: saner st=
ruct file treatment
> git bisect bad ccc54b556054d20a1e04eac48200e63e6b87fe1c
> # test job: [b320789d6883cc00ac78ce83bccbfe7ed58afcf0] https://lava.siren=
a.org.uk/scheduler/job/1756559
> # good: [b320789d6883cc00ac78ce83bccbfe7ed58afcf0] Linux 6.17-rc4
> git bisect good b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> # first bad commit: [ccc54b556054d20a1e04eac48200e63e6b87fe1c] kernel/acc=
t.c: saner struct file treatment


--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR

