Return-Path: <linux-fsdevel+bounces-69091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DAC6F040
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C09C4F5A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F9366573;
	Wed, 19 Nov 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATUBygQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0708364051;
	Wed, 19 Nov 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558211; cv=none; b=WplWgNjkVCQGqdAJDJZwRIJAWDa1c79Mnim4Uv43ptGRuoJWcoLrIF05BpaE+Sr9UfUZ5sfMM5ZGwAFiEgFLzLjzDVZyxyfayOcNujqGWKgZksXR1ruNQt+eIWVgXSUDWSfEBt7l3zPDz4FMe0GiGp9lHq28Vg4tj2/X56+tKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558211; c=relaxed/simple;
	bh=x24iHscgwWXz8zcfDfJ8EPqf0ndoOIcHpd6ojxGCgWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqghYRrjS17uE52n+crJudNQXmC1AwRcu9Vs0dnhIM94Es7/uGuSmuMftGmV4MRIFMkcahjkDyQy+F8KLfEMqhF2t6TUsbI5eEEZys31bPkekW0WTn98mGHPjzzWI5IuPZwyjiF53kVqzK5jZXFcKcZar4hM/rxbFBAh1GFzbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATUBygQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF1C2BC87;
	Wed, 19 Nov 2025 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763558207;
	bh=x24iHscgwWXz8zcfDfJ8EPqf0ndoOIcHpd6ojxGCgWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATUBygQfx/VrGJk3+O21/fRnmRmHKYEYl+8810qcSedGpSebuF4sTjbdwg0FYjunK
	 dT1RfRcqdoKGs3nF62lr5FvdxBeJfBliTkaB2vb7WiQ576ySOeigbju6M/PPFmArga
	 NBUkaaam2SBsmizxu8MQ6PdnjU++POqcTmiNsqihYt71YyU08msPVQ8FEkI1VbZM5C
	 rY7Z2M5T/BIwk2TOu2Z6BL5VcM4cnqEaR1DIvgYuoDDNdqfuiLf6kqKkxl9nNe5+uL
	 XTwLUE2m0XbgwgPhoiEocU84RceRYi3pihqf/hDjuu7de+C3PwR4rpe2Eq44gBW4tV
	 D90bcmjYKuFwQ==
Date: Wed, 19 Nov 2025 13:16:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <25cb4b6a-035b-4193-a8db-685fc4c58507@sirena.org.uk>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8R4WppGBpWuwqpgN"
Content-Disposition: inline
In-Reply-To: <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
X-Cookie: This screen intentionally left blank.


--8R4WppGBpWuwqpgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> It is useful to be able to designate that certain flags are 'sticky', that
> is, if two VMAs are merged one with a flag of this nature and one without,
> the merged VMA sets this flag.

I'm seeing regressions on multiple arm64 platforms in at least the LTP
clone302 and madvise10 selftests, both of which have bisected to one of
the fixups to this patch.  Especially given the other tests that also
bisected to the same place I've not investigated further.  There's a
number of other LTP tests that started failing today including relevant
seeming ones munlockall01, mprotect04, madvise10, mprotect03 and
futex_cmp_requeue01 but I don't have bisects to confirm they're the same
thing.

clone302:

tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_clorMwMMw as tmpdir (nfs filesystem)
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-next-20251119 #1 SMP PREE=
MPT @1763523415 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 24s
clone302.c:61: TPASS: sizeof(struct clone_args_minimal) =3D=3D 64 (64)
clone302.c:102: TPASS: invalid args: clone3() failed as expected: EFAULT (1=
4)
clone302.c:102: TPASS: zero size: clone3() failed as expected: EINVAL (22)
clone302.c:102: TPASS: short size: clone3() failed as expected: EINVAL (22)
clone302.c:92: TFAIL: extra size: clone3() passed unexpectedly
clone302.c:102: TPASS: sighand-no-VM: clone3() failed as expected: EINVAL (=
22)
clone302.c:102: TPASS: thread-no-sighand: clone3() failed as expected: EINV=
AL (22)
clone302.c:102: TPASS: fs-newns: clone3() failed as expected: EINVAL (22)
clone302.c:102: TPASS: invalid pidfd: clone3() failed as expected: EFAULT (=
14)
clone302.c:102: TPASS: invalid signal: clone3() failed as expected: EINVAL =
(22)
clone302.c:102: TPASS: zero-stack-size: clone3() failed as expected: EINVAL=
 (22)
clone302.c:102: TPASS: invalid-stack: clone3() failed as expected: EINVAL (=
22)

madvise10:

tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-next-20251119 #1 SMP PREE=
MPT @1763523415 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 24s
madvise10.c:133: TINFO: MADV_WIPEONFORK zeroes memory in child
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x0)
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x12)
madvise10.c:88: TPASS: In PID 660, Matched expected pattern
madvise10.c:133: TINFO: MADV_WIPEONFORK with zero length does nothing
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 0, 0x0)
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 0, 0x12)
madvise10.c:88: TPASS: In PID 661, Matched expected pattern
madvise10.c:133: TINFO: MADV_WIPEONFORK zeroes memory in grand-child
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x0)
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x12)
madvise10.c:88: TPASS: In PID 663, Matched expected pattern
madvise10.c:133: TINFO: MADV_KEEPONFORK will undo MADV_WIPEONFORK
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x12)
madvise10.c:107: TPASS: madvise(0xffffa8fbc000, 16384, 0x13)
madvise10.c:81: TFAIL: In PID 664, addr[1] =3D 0x00, expected[1] =3D 0x01
madvise10.c:88: TPASS: In PID 664, Matched expected pattern

The bisects for both follow the same pattern:

# bad: [fe4d0dea039f2befb93f27569593ec209843b0f5] Add linux-next specific f=
iles for 20251119
# good: [ef96b7dd050abd62905588c41ffb397e0c9598c7] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] MAINTAINERS: adjust file=
 entry in RISC-V MICROCHIP SUPPORT
# good: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] regulator: renesas-usb-v=
bus-regulator: Remove unused headers
# good: [96498e804cb6629e02747336a0a33e4955449732] spi: davinci: remove pla=
tform data header
# good: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] ASoC: ux500: mop500_ab85=
00: convert to snd_soc_dapm_xxx()
# good: [9e510e677090bb794b46348b10e1c8038286e00a] spi: aspeed: Add support=
 for the AST2700 SPI controller
# good: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] ASoC: Intel: avs: Honor =
NHLT override when setting up a path
# good: [118eb2cb97b8fc0d515bb0449495959247db58f0] spi: bcm63xx: drop wrong=
 casts in probe()
# good: [059f545832be85d29ac9ccc416a16f647aa78485] spi: add support for mic=
rochip "soft" spi controller
# good: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] MAINTAINERS: refer to tr=
ivial-codec.yaml in relevant sections
# good: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] spi: spi-cadence: suppor=
ts transmission with bits_per_word of 16 and 32
# good: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] ASoC: codecs: lpass-rx-m=
acro: add SM6115 compatible
# good: [e65b871c9b5af9265aefc5b8cd34993586d93aab] ASoC: codecs: pm4125: Re=
move irq_chip on component unbind
# good: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] firmware: cs_dsp: fix ke=
rnel-doc warnings in a header file
# good: [123cd174a3782307787268adf45f22de4d290128] ASoC: Intel: atom: Repla=
ce strcpy() with strscpy()
# good: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] ASoC: Intel: boards: fix=
 HDMI playback lookup when HDMI-In capture used
# good: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] spi: dt-bindings: nuvoto=
n,npcm-pspi: Convert to DT schema
# good: [873bc94689d832878befbcadc10b6ad5bb4e0027] ASoC: Intel: sof_sdw: ad=
d codec speaker support for the SKU
# good: [32172cf3cb543a04c41a1677c97a38e60cad05b6] ASoC: cs35l56: Allow res=
toring factory calibration through ALSA control
# good: [b3a5302484033331af37569f7277d00131694b57] ASoC: Intel: sof_rt5682:=
 Add quirk override support
# good: [772ada50282b0c80343c8989147db816961f571d] ASoC: cs35l56: Alter err=
or codes for calibration routine
# good: [fb1ebb10468da414d57153ddebaab29c38ef1a78] regulator: core: disable=
 supply if enabling main regulator fails
# good: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] regmap: sdw-mbq: Reorder=
 regmap_mbq_context struct for better packing
# good: [2089f086303b773e181567fd8d5df3038bd85937] regulator: mt6363: Remov=
e unneeded semicolon
# good: [6951be397ca8b8b167c9f99b5a11c541148c38cb] ASoC: codecs: pm4125: re=
move duplicate code
# good: [4e92abd0a11b91af3742197a9ca962c3c00d0948] spi: imx: add i.MX51 ECS=
PI target mode support
# good: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] spi: fsl-qspi: support t=
he SpacemiT K1 SoC
# good: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] ASoC: SDCA: support Q7.8=
 volume format
# good: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] spi: imx: remove CLK cal=
culation and check for target mode
# good: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] regulator: pf9453: Fix k=
ernel doc for mux_poll()
# good: [655079ac8a7721ac215a0596e3f33b740e01144a] ASoC: qcom: q6asm: Use g=
uard() for spin locks
# good: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] spi: aspeed: Use devm_io=
unmap() to unmap devm_ioremap() memory
# good: [3c36965df80801344850388592e95033eceea05b] regulator: Add support f=
or MediaTek MT6363 SPMI PMIC Regulators
# good: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] ASoC: dt-bindings: ti,pc=
m1862: convert to dtschema
# good: [c4e68959af66df525d71db619ffe44af9178bb22] ASoC: dt-bindings: ti,ta=
s2781: Add TAS5822 support
# good: [380fd29d57abe6679d87ec56babe65ddc5873a37] spi: tegra210-quad: Chec=
k hardware status on timeout
# good: [af9c8092d84244ca54ffb590435735f788e7a170] regmap: i3c: Use ARRAY_S=
IZE()
# good: [2ecc8c089802e033d2e5204d21a9f467e2517df9] regulator: pf9453: remov=
e unused I2C_LT register
# good: [84194c66aaf78fed150edb217b9f341518b1cba2] ASoC: codecs: aw88261: p=
ass pointer directly instead of passing the address
# good: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] regulator: Small cleanup=
 in of_get_regulation_constraints()
# good: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] regcache: maple: Split -=
>populate() from ->init()
# good: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] ASoC: soc-core: check op=
s & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereference=
 error
# good: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] ASoC: max98090/91: fixin=
g the stream index
# good: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] ASoC: codec: wm8400: rep=
lace printk() calls with dev_*() device aware logging
# good: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] spi: tle62x0: Add newlin=
e to sysfs attribute output
# good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add suppor=
t for the external mclk
# good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro: =
fix revision checking
# good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users about=
 uninitialized flat cache
# good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: make=
 use of common helpers
# good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove obso=
lete file entry in DIALOG SEMICONDUCTOR DRIVERS
# good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fail=
ure check for spacemit_i2s_init_dai()
# good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `dep=
ends on` instead of `select`
# good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Suppo=
rt SPDIF output on A523 family
# good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID butt=
on IRQ
# good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: link=
 regulator inputs to supply groups
# good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI bu=
s support for cs530x parts
# good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace exec=
_op
# good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspberry=
pi drivers depend on ARM
# good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test: A=
dd test cases for cs_amp_set_efi_calibration_data()
# good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Cons=
tify struct fsi_stream_handler
# good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: add =
qrb2210-sndcard compatible string
# good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add nam=
e_prefix for rt1321 part id
# good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fixin=
g a space
# good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: mak=
e qcom_spi_ecc_engine_ops_pipelined const
# good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regulato=
r: Add RPMH regulator support for PMR735D
# good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: addin=
g DAPM routing for digital output for max98091
# good: [638bae3fb225a708dc67db613af62f6d14c4eff4] ASoC: max98090/91: added=
 DAPM widget for digital output for max98091
# good: [ecba655bf54a661ffe078856cd8dbc898270e4b5] ASoC: fsl_aud2htx: add I=
EC958_SUBFRAME_LE format in supported list
# good: [7e1906643a7374529af74b013bba35e4fa4e6ffc] ASoC: codecs: va-macro: =
Clean up on error path in probe()
# good: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] ASoC: soc.h: remove snd_=
soc_kcontrol_component()
# good: [6658472a3e2de08197acfe099ba71ee0e2505ecf] ASoC: amd: amd_sdw: Prop=
agate the PCI subsystem Vendor and Device IDs
# good: [fce217449075d59b29052b8cdac567f0f3e22641] ASoC: spacemit: add i2s =
support for K1 SoC
# good: [5677aa6a08c1df8bc1ec71516fe1ced9b7cb545f] HID: intel-ish-hid: ipc:=
 Separate hibernate callbacks in dev_pm_ops
# good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS_E=
RR() vs NULL bug in probe()
# good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer must=
 be 0xff-ed before writing
# good: [b1fc226edf8680882a5bf89038bdc55afa2ac80d] media: stm32: dma2d: Dro=
p unneeded v4l2_m2m_get_vq() NULL check
# good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qcom:=
 Add Kaanapali LPASS macro codecs
# good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spellin=
g mistake "triming" -> "trimming"
# good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: support =
usage with simple-audio-card
# good: [0d7f4e99217f6f715c7064c67eae8d9d09313b14] drm/i915/display: Introd=
uce dp/psr_compute_config_late()
# good: [fb25114cd760c13cf177d9ac37837fafcc9657b5] regulator: sy7636a: add =
gpios and input regulator
# good: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] regulator: rpmh-regulato=
r: Add RPMH regulator support for Glymur
# good: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] ASoC: codecs: rt5670: us=
e SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
# good: [433e294c3c5b5d2020085a0e36c1cb47b694690a] regulator: core: forward=
 undervoltage events downstream by default
# good: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] ASoC: replace use of sys=
tem_wq with system_dfl_wq
# good: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] x86/module: Improve relo=
cation error messages
# good: [c2d420796a427dda71a2400909864e7f8e037fd4] elfnote: Change ELFNOTE(=
) to use __UNIQUE_ID()
# good: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
# good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-qp=
ic-snand: Add IPQ5332 compatible
# good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the er=
ror of excessive semicolons
# good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map ne=
cessary address window region
# good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Upda=
te ADMAIF bindings for tegra264
# good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
# good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mode=
 support
# good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings: =
Convert Dialog DA9211 Regulators to DT schema
# good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offset=
 parameter
# good: [807c42dd8028d71222dfce035c2e87aaecbf623f] drm/xe: Don't change LRC=
 ring head on job resubmission
# good: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] Merge branch 'next/drive=
rs' into for-next
git bisect start 'fe4d0dea039f2befb93f27569593ec209843b0f5' 'ef96b7dd050abd=
62905588c41ffb397e0c9598c7' 'bd79452b39c21599e2cff42e9fbeb182656b6f6a' '21e=
68bcb1b0c688c2d9ca0d457922febac650ac1' '96498e804cb6629e02747336a0a33e49554=
49732' '4422df6782eb7aa9725a3c09d9ba3c38ecc85df4' '9e510e677090bb794b46348b=
10e1c8038286e00a' 'd5c8b7902a41625ea328b52c78ebe750fbf6fef7' '118eb2cb97b8f=
c0d515bb0449495959247db58f0' '059f545832be85d29ac9ccc416a16f647aa78485' '64=
02ddf3027d8975f135cf2b2014d6bbeb2d3436' '4e00135b2dd1d7924a58bffa551b6ceb3b=
d836f2' '8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10' 'e65b871c9b5af9265aefc5b=
8cd34993586d93aab' '8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860' '123cd174a378=
2307787268adf45f22de4d290128' '4d6e2211aeb932e096f673c88475016b1cc0f8ab' '1=
d562ba0aa7df81335bf96c02be77efe8d5bab87' '873bc94689d832878befbcadc10b6ad5b=
b4e0027' '32172cf3cb543a04c41a1677c97a38e60cad05b6' 'b3a5302484033331af3756=
9f7277d00131694b57' '772ada50282b0c80343c8989147db816961f571d' 'fb1ebb10468=
da414d57153ddebaab29c38ef1a78' '6985defd1d832f1dd9d1977a6a2cc2cef7632704' '=
2089f086303b773e181567fd8d5df3038bd85937' '6951be397ca8b8b167c9f99b5a11c541=
148c38cb' '4e92abd0a11b91af3742197a9ca962c3c00d0948' 'abc9a349b87ac0fd3ba87=
87ca00971b59c2e1257' '1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69' '55d03b5b5b=
dd04daf9a35ce49db18d8bb488dffb' '6bd1ad97eb790570c167d4de4ca59fbc9c33722a' =
'655079ac8a7721ac215a0596e3f33b740e01144a' '2f538ef9f6f7c3d700c68536f21447d=
fc598f8c8' '3c36965df80801344850388592e95033eceea05b' 'aa897ffc396b48cc39ee=
e133b6b43175d0df9eb5' 'c4e68959af66df525d71db619ffe44af9178bb22' '380fd29d5=
7abe6679d87ec56babe65ddc5873a37' 'af9c8092d84244ca54ffb590435735f788e7a170'=
 '2ecc8c089802e033d2e5204d21a9f467e2517df9' '84194c66aaf78fed150edb217b9f34=
1518b1cba2' '252abf2d07d33b1c70a59ba1c9395ba42bbd793e' 'ed5d499b5c9cc11dd3e=
dae1a7a55db7dfa4f1bdc' 'e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0' 'f1dfbc1b=
5cf8650ae9a0d543e5f5335fc0f478ce' '6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3=
' 'ecd0de438c1f0ee86cf8f6d5047965a2a181444b' 'cf6bf51b53252284bafc7377a4d8d=
bf10f048b4d' '20bcda681f8597e86070a4b3b12d1e4f541865d3' 'e062bdfdd6adbb2dee=
7751d054c1d8df63ddb8b8' '8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce' '28039ef=
a4d8e8bbf98b066133a906bd4e307d496' 'f034c16a4663eaf3198dc18b201ba50533fb5b8=
1' '66fecfa91deb536a12ddf3d878a99590d7900277' '4a5ac6cd05a7e54f1585d7779464=
d6ed6272c134' 'ef042df96d0e1089764f39ede61bc8f140a4be00' '4c33cef58965eb655=
a0ac8e243aa323581ec025f' 'e7434adf0c53a84d548226304cdb41c8818da1cb' '77a58b=
a7c64ccca20616aa03599766ccb0d1a330' '01313661b248c5ba586acae09bff57077dbec0=
a5' '4795375d8aa072e9aacb0b278e6203c6ca41816a' 'd29479abaded34b2b1dab2e17ef=
e96a65eba3d61' 'e973dfe9259095fb509ab12658c68d46f0e439d7' 'c17fa4cbc546c431=
ccf13e9354d5d9c1cd247b7c' '310bf433c01f78e0756fd5056a43118a2f77318c' 'fd5ef=
3d69f8975bad16c437a337b5cb04c8217a2' 'd054cc3a2ccfb19484f3b54d69b6e416832dc=
8f4' '2528c15f314ece50218d1273654f630d74109583' '638bae3fb225a708dc67db613a=
f62f6d14c4eff4' 'ecba655bf54a661ffe078856cd8dbc898270e4b5' '7e1906643a73745=
29af74b013bba35e4fa4e6ffc' 'd742ebcfe524dc54023f7c520d2ed2e4b7203c19' '6658=
472a3e2de08197acfe099ba71ee0e2505ecf' 'fce217449075d59b29052b8cdac567f0f3e2=
2641' '5677aa6a08c1df8bc1ec71516fe1ced9b7cb545f' '0cc08c8130ac8f74419f99fe7=
07dc193b7f79d86' '0743acf746a81e0460a56fd5ff847d97fa7eb370' 'b1fc226edf8680=
882a5bf89038bdc55afa2ac80d' '15afe57a874eaf104bfbb61ec598fa31627f7b19' 'd77=
daa49085b067137d0adbe3263f75a7ee13a1b' '1e570e77392f43a3cdab2849d1f81535f8a=
033e2' '0d7f4e99217f6f715c7064c67eae8d9d09313b14' 'fb25114cd760c13cf177d9ac=
37837fafcc9657b5' '65efe5404d151767653c7b7dd39bd2e7ad532c2d' '6621b0f118d50=
0092f5f3d72ddddb22aeeb3c3a0' '433e294c3c5b5d2020085a0e36c1cb47b694690a' '0b=
0eb7702a9fa410755e86124b4b7cd36e7d1cb4' 'bf770d6d2097a52d87f4d9c88d0b05bd39=
98d7de' 'c2d420796a427dda71a2400909864e7f8e037fd4' '7e7e2c6e2a1cb250f8d03bb=
99eed01f6d982d5dd' '4412ab501677606436e5c49e41151a1e6eac7ac0' '5e537031f322=
d55315cd384398b726a9a0748d47' '64d87ccfae3326a9561fe41dc6073064a083e0df' '4=
d410ba9aa275e7990a270f63ce436990ace1bea' '9797329220a2c6622411eb9ecf6a35b24=
ce09d04' 'fe8cc44dd173cde5788ab4e3730ac61f3d316d9c' '6277a486a7faaa6c87f4bf=
1d59a2de233a093248' 'b83fb1b14c06bdd765903ac852ba20a14e24f227' '807c42dd802=
8d71222dfce035c2e87aaecbf623f' '6c177775dcc5e70a64ddf4ee842c66af498f2c7c'
# test job: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] https://lava.sirena.=
org.uk/scheduler/job/2104086
# test job: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] https://lava.sirena.=
org.uk/scheduler/job/2104526
# test job: [96498e804cb6629e02747336a0a33e4955449732] https://lava.sirena.=
org.uk/scheduler/job/2099727
# test job: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] https://lava.sirena.=
org.uk/scheduler/job/2097779
# test job: [9e510e677090bb794b46348b10e1c8038286e00a] https://lava.sirena.=
org.uk/scheduler/job/2093905
# test job: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] https://lava.sirena.=
org.uk/scheduler/job/2092717
# test job: [118eb2cb97b8fc0d515bb0449495959247db58f0] https://lava.sirena.=
org.uk/scheduler/job/2092417
# test job: [059f545832be85d29ac9ccc416a16f647aa78485] https://lava.sirena.=
org.uk/scheduler/job/2086746
# test job: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] https://lava.sirena.=
org.uk/scheduler/job/2086625
# test job: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] https://lava.sirena.=
org.uk/scheduler/job/2082495
# test job: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] https://lava.sirena.=
org.uk/scheduler/job/2083122
# test job: [e65b871c9b5af9265aefc5b8cd34993586d93aab] https://lava.sirena.=
org.uk/scheduler/job/2083037
# test job: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] https://lava.sirena.=
org.uk/scheduler/job/2082590
# test job: [123cd174a3782307787268adf45f22de4d290128] https://lava.sirena.=
org.uk/scheduler/job/2078937
# test job: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] https://lava.sirena.=
org.uk/scheduler/job/2078014
# test job: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] https://lava.sirena.=
org.uk/scheduler/job/2078351
# test job: [873bc94689d832878befbcadc10b6ad5bb4e0027] https://lava.sirena.=
org.uk/scheduler/job/2074819
# test job: [32172cf3cb543a04c41a1677c97a38e60cad05b6] https://lava.sirena.=
org.uk/scheduler/job/2075088
# test job: [b3a5302484033331af37569f7277d00131694b57] https://lava.sirena.=
org.uk/scheduler/job/2074568
# test job: [772ada50282b0c80343c8989147db816961f571d] https://lava.sirena.=
org.uk/scheduler/job/2069245
# test job: [fb1ebb10468da414d57153ddebaab29c38ef1a78] https://lava.sirena.=
org.uk/scheduler/job/2059767
# test job: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] https://lava.sirena.=
org.uk/scheduler/job/2059097
# test job: [2089f086303b773e181567fd8d5df3038bd85937] https://lava.sirena.=
org.uk/scheduler/job/2058075
# test job: [6951be397ca8b8b167c9f99b5a11c541148c38cb] https://lava.sirena.=
org.uk/scheduler/job/2055750
# test job: [4e92abd0a11b91af3742197a9ca962c3c00d0948] https://lava.sirena.=
org.uk/scheduler/job/2055873
# test job: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] https://lava.sirena.=
org.uk/scheduler/job/2054602
# test job: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] https://lava.sirena.=
org.uk/scheduler/job/2053511
# test job: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] https://lava.sirena.=
org.uk/scheduler/job/2053867
# test job: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] https://lava.sirena.=
org.uk/scheduler/job/2053537
# test job: [655079ac8a7721ac215a0596e3f33b740e01144a] https://lava.sirena.=
org.uk/scheduler/job/2049694
# test job: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] https://lava.sirena.=
org.uk/scheduler/job/2048653
# test job: [3c36965df80801344850388592e95033eceea05b] https://lava.sirena.=
org.uk/scheduler/job/2049502
# test job: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] https://lava.sirena.=
org.uk/scheduler/job/2048768
# test job: [c4e68959af66df525d71db619ffe44af9178bb22] https://lava.sirena.=
org.uk/scheduler/job/2044048
# test job: [380fd29d57abe6679d87ec56babe65ddc5873a37] https://lava.sirena.=
org.uk/scheduler/job/2044588
# test job: [af9c8092d84244ca54ffb590435735f788e7a170] https://lava.sirena.=
org.uk/scheduler/job/2043656
# test job: [2ecc8c089802e033d2e5204d21a9f467e2517df9] https://lava.sirena.=
org.uk/scheduler/job/2038631
# test job: [84194c66aaf78fed150edb217b9f341518b1cba2] https://lava.sirena.=
org.uk/scheduler/job/2038367
# test job: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] https://lava.sirena.=
org.uk/scheduler/job/2038561
# test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.sirena.=
org.uk/scheduler/job/2029031
# test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.sirena.=
org.uk/scheduler/job/2026425
# test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.sirena.=
org.uk/scheduler/job/2025503
# test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.sirena.=
org.uk/scheduler/job/2025871
# test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.sirena.=
org.uk/scheduler/job/2026135
# test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.sirena.=
org.uk/scheduler/job/2023024
# test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.sirena.=
org.uk/scheduler/job/2022953
# test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.sirena.=
org.uk/scheduler/job/2020135
# test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.sirena.=
org.uk/scheduler/job/2021440
# test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.sirena.=
org.uk/scheduler/job/2020322
# test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.sirena.=
org.uk/scheduler/job/2015432
# test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.sirena.=
org.uk/scheduler/job/2015351
# test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.sirena.=
org.uk/scheduler/job/2011285
# test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.sirena.=
org.uk/scheduler/job/2010192
# test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.sirena.=
org.uk/scheduler/job/2009429
# test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.sirena.=
org.uk/scheduler/job/2007770
# test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.sirena.=
org.uk/scheduler/job/2007322
# test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.sirena.=
org.uk/scheduler/job/2008874
# test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.sirena.=
org.uk/scheduler/job/2009678
# test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.sirena.=
org.uk/scheduler/job/2008461
# test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.sirena.=
org.uk/scheduler/job/2008113
# test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.sirena.=
org.uk/scheduler/job/2000039
# test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.sirena.=
org.uk/scheduler/job/1996043
# test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.sirena.=
org.uk/scheduler/job/1996112
# test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.sirena.=
org.uk/scheduler/job/1995713
# test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.sirena.=
org.uk/scheduler/job/1997616
# test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.sirena.=
org.uk/scheduler/job/1991887
# test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.sirena.=
org.uk/scheduler/job/1985123
# test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.sirena.=
org.uk/scheduler/job/1978610
# test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.sirena.=
org.uk/scheduler/job/1975999
# test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.sirena.=
org.uk/scheduler/job/1973530
# test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.sirena.=
org.uk/scheduler/job/1975656
# test job: [5677aa6a08c1df8bc1ec71516fe1ced9b7cb545f] https://lava.sirena.=
org.uk/scheduler/job/1978817
# test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.sirena.=
org.uk/scheduler/job/1965701
# test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.sirena.=
org.uk/scheduler/job/1964858
# test job: [b1fc226edf8680882a5bf89038bdc55afa2ac80d] https://lava.sirena.=
org.uk/scheduler/job/1978391
# test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.sirena.=
org.uk/scheduler/job/1962906
# test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.sirena.=
org.uk/scheduler/job/1962818
# test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.sirena.=
org.uk/scheduler/job/1962269
# test job: [0d7f4e99217f6f715c7064c67eae8d9d09313b14] https://lava.sirena.=
org.uk/scheduler/job/1980262
# test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.sirena.=
org.uk/scheduler/job/1960133
# test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.sirena.=
org.uk/scheduler/job/1959948
# test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.sirena.=
org.uk/scheduler/job/1959732
# test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.sirena.=
org.uk/scheduler/job/1957354
# test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.sirena.=
org.uk/scheduler/job/1957417
# test job: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] https://lava.sirena.=
org.uk/scheduler/job/1984426
# test job: [c2d420796a427dda71a2400909864e7f8e037fd4] https://lava.sirena.=
org.uk/scheduler/job/1984520
# test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.sirena.=
org.uk/scheduler/job/1954251
# test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.sirena.=
org.uk/scheduler/job/1946234
# test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.sirena.=
org.uk/scheduler/job/1946679
# test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.sirena.=
org.uk/scheduler/job/1947242
# test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.sirena.=
org.uk/scheduler/job/1947841
# test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.sirena.=
org.uk/scheduler/job/1947406
# test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.sirena.=
org.uk/scheduler/job/1946044
# test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.sirena.=
org.uk/scheduler/job/1947003
# test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.sirena.=
org.uk/scheduler/job/1946832
# test job: [807c42dd8028d71222dfce035c2e87aaecbf623f] https://lava.sirena.=
org.uk/scheduler/job/1981864
# test job: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] https://lava.sirena.=
org.uk/scheduler/job/1780443
# test job: [fe4d0dea039f2befb93f27569593ec209843b0f5] https://lava.sirena.=
org.uk/scheduler/job/2106238
# bad: [fe4d0dea039f2befb93f27569593ec209843b0f5] Add linux-next specific f=
iles for 20251119
git bisect bad fe4d0dea039f2befb93f27569593ec209843b0f5
# test job: [40506e4c543a64ad5846f0a532d5ea16310fd9e3] https://lava.sirena.=
org.uk/scheduler/job/2106514
# bad: [40506e4c543a64ad5846f0a532d5ea16310fd9e3] Merge branch 'for-next' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad 40506e4c543a64ad5846f0a532d5ea16310fd9e3
# test job: [e510eda33592ffbe54b55476040348b552674cd3] https://lava.sirena.=
org.uk/scheduler/job/2106557
# bad: [e510eda33592ffbe54b55476040348b552674cd3] Merge branch 'next' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
git bisect bad e510eda33592ffbe54b55476040348b552674cd3
# test job: [8903539518403d5e9a7ac09ea2486ed297f337e5] https://lava.sirena.=
org.uk/scheduler/job/2106617
# bad: [8903539518403d5e9a7ac09ea2486ed297f337e5] Merge branch 'for-next' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git
git bisect bad 8903539518403d5e9a7ac09ea2486ed297f337e5
# test job: [fb6b3841aabe2098b0610eaf9edac0fc562a122f] https://lava.sirena.=
org.uk/scheduler/job/2106645
# bad: [fb6b3841aabe2098b0610eaf9edac0fc562a122f] Merge branch 'kbuild-next=
' of https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
git bisect bad fb6b3841aabe2098b0610eaf9edac0fc562a122f
# test job: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] https://lava.sirena.=
org.uk/scheduler/job/2106738
# good: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] mm: implement sticky VMA=
 flags
git bisect good f24f3801039f9a2033e3a2390fccc5adc00a8df7
# test job: [420203301ca3aef72980c78534264c4ec7f672d0] https://lava.sirena.=
org.uk/scheduler/job/2106793
# good: [420203301ca3aef72980c78534264c4ec7f672d0] Revert "lib/plist.c: enf=
orce memory ordering in plist_check_list"
git bisect good 420203301ca3aef72980c78534264c4ec7f672d0
# test job: [259dbf8c45694409126841a8769c111869fec9c8] https://lava.sirena.=
org.uk/scheduler/job/2106834
# bad: [259dbf8c45694409126841a8769c111869fec9c8] mm/damon/vaddr: consisten=
tly use only pmd_entry for damos_migrate
git bisect bad 259dbf8c45694409126841a8769c111869fec9c8
# test job: [529b176c64b658d258493a03d88126c69aeae25b] https://lava.sirena.=
org.uk/scheduler/job/2106989
# bad: [529b176c64b658d258493a03d88126c69aeae25b] mm: replace remaining pte=
_to_swp_entry() with softleaf_from_pte()
git bisect bad 529b176c64b658d258493a03d88126c69aeae25b
# test job: [abedb72c9bfdd177a446ed4c29b50d9dea239471] https://lava.sirena.=
org.uk/scheduler/job/2107057
# bad: [abedb72c9bfdd177a446ed4c29b50d9dea239471] mm: introduce leaf entry =
type and use to simplify leaf entry logic
git bisect bad abedb72c9bfdd177a446ed4c29b50d9dea239471
# test job: [b789b80819cdef357c78e613a28f36d1ef7975bf] https://lava.sirena.=
org.uk/scheduler/job/2107105
# bad: [b789b80819cdef357c78e613a28f36d1ef7975bf] tools/testing/vma: add VM=
A sticky userland tests
git bisect bad b789b80819cdef357c78e613a28f36d1ef7975bf
# test job: [b331f7745489548c5a020301f6f3b4aad20c7b77] https://lava.sirena.=
org.uk/scheduler/job/2107143
# bad: [b331f7745489548c5a020301f6f3b4aad20c7b77] mm: introduce copy-on-for=
k VMAs and make VM_MAYBE_GUARD one
git bisect bad b331f7745489548c5a020301f6f3b4aad20c7b77
# test job: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] https://lava.sirena.=
org.uk/scheduler/job/2107226
# bad: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] mm-implement-sticky-vma-f=
lags-fix-2
git bisect bad 2c91ae77d8fbafb153c13e554f50b7bbeef59d76
# test job: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] https://lava.sirena.=
org.uk/scheduler/job/2107256
# bad: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-implement-sticky-vma-f=
lags-fix
git bisect bad 79ee48c12ef8fe9a3daf0dbeda74f038a3f557be
# first bad commit: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-implement=
-sticky-vma-flags-fix

--8R4WppGBpWuwqpgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkdwzQACgkQJNaLcl1U
h9DdoQgAgq/frQCNWXv75TgXlpbK8uijA2OLml7Ffb25QCIjZH0riwLcOg5nl/e0
A89YOyj4ObnpJw0J+lvaedWgyfueb4vOekR5dU1vaDlPfRPa/dsgPVCuubg6pu9O
SfGiEOhyckiZsqrG4+gza1mhaP/q3PQXd7BN4g2BOo9axIsxGOSc1ViOIGnygNay
9p88yzJ3y3oKNrDBJLg7gLFe1Nb+YyaXizSNCmVRvO+FMY+qtyIDFRQpZvghMnr3
kTVqhbOmNRaGb93eQgMTQFyXd6qJarkbnA5pxhLtN9sZtVgbFxjAO5pmVhqncSlH
bKoX7YloRzCVrn66hpdP7wDV+WQaZQ==
=Wctg
-----END PGP SIGNATURE-----

--8R4WppGBpWuwqpgN--

