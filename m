Return-Path: <linux-fsdevel+bounces-69088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DCC6EC47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 102EC4FB6D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB2359F8F;
	Wed, 19 Nov 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwLMtcuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38979358D0D;
	Wed, 19 Nov 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556941; cv=none; b=ZXloNNwwakYzp3GIzoCfwT48pYOXfreXOfDPKmNdSOk7CvLogqeTS6oUu4t+Yj7UDrJRi7mtQ7Skx8pFw2MX8Eq8zF61/34BxAkK1k41+wuMmqAnf3mTP+7Kl4IysrvpN8MF+T0tbvZhJDxKtTMLQg3LQMycsSNDl/RE/TnoE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556941; c=relaxed/simple;
	bh=YwaOhaJYwL3hyKX8Duyw40XwFjQNv2faelUDW0o3+eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueNEf/Z9bI7IeNPMntpPZyZ5mh6pUU24FJ/ZlWZ48R77GCjHfZd1txs6CAPvl0W1usBOtHHp5qFKGLXpfQXjx+CHCLyfEcCK869TE7+5Gq4cA2WTEvX5dx9C3W7GRBKxOJXO8UuGSaD3+POrsR0bTGgKPFjVR23Fcu+PgCWEgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwLMtcuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D11C19422;
	Wed, 19 Nov 2025 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763556939;
	bh=YwaOhaJYwL3hyKX8Duyw40XwFjQNv2faelUDW0o3+eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwLMtcuwOiPl50foMzoOyG9y7FCCdEoTiM0TKHrGM0otlsmAzchi9KAYMsEJc2dGw
	 jweIxQDOHgDHMRSc3JDzQ34POFxafrKkPTJGfkva45gx24gsJlw2pqtj4yxi4dK+9R
	 VSQ0UyH9DJyJRuUohYASb15WjS1F7yzhVl8T+HveWBdblXufDZp9iI4sDdew667Yb8
	 S1QdDhD2CKI/wmFTHCCJDerL/jbwNJ+bGGM9mQBrE3xF3c72QBjAxYWz/dOkwaAFDd
	 W/kvjpE2xnZCrvm7JQZFHAVN3d76/nXVypf/WpYmTIGbthuAHglgsp8uw9ZoqlaTKb
	 yvzLPA4zUQ2sA==
Date: Wed, 19 Nov 2025 12:55:29 +0000
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
Message-ID: <2ab7be71-716a-40c0-adb7-01e7474546d0@sirena.org.uk>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HRdD9s9wZleQ0exp"
Content-Disposition: inline
In-Reply-To: <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
X-Cookie: This screen intentionally left blank.


--HRdD9s9wZleQ0exp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> It is useful to be able to designate that certain flags are 'sticky', that
> is, if two VMAs are merged one with a flag of this nature and one without,
> the merged VMA sets this flag.

I'm seeing a regression in the futex selftests on arm64:

# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.futex_numa_mpol ...
# # Regular test
# # Mis-aligned futex
# # Memory out of range
# Bail out! futex2_wake(64, 0x86) should fail, but didn't
# # Planned tests !=3D run tests (1 !=3D 0)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
# # futex_numa_mpol: Test failed
# #          FAIL  global.futex_numa_mpol
# not ok 1 global.futex_numa_mpol
# # FAILED: 0 / 1 tests passed.

which bisect to one of the fixup commits on top of this.  I've not done
any real analysis on this but it's a test that's generally very stable
so I'd be surprised if it's not a real failure.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2106243#L11474

There is also a bisection for the mm mkdirty selftest which runs into
the same patch on at least Raspberry Pi 4:

# # -----------------
# # running ./mkdirty
# # -----------------
# # # [INFO] detected THP size: 2048 KiB
# # TAP version 13
# # 1..6
# # # [INFO] PTRACE write access
# # ok 1 SIGSEGV generated, page not modified
# # # [INFO] PTRACE write access to THP
# # ok 2 SIGSEGV generated, page not modified
# # # [INFO] Page migration
# # not ok 3 SIGSEGV generated, page not modified
# # # [INFO] Page migration of THP
# # not ok 4 SIGSEGV generated, page not modified
# # # [INFO] PTE-mapping a THP
# # not ok 5 SIGSEGV generated, page not modified
# # # [INFO] UFFDIO_COPY
# # ok 6 # SKIP __NR_userfaultfd failed
# # Bail out! 3 out of 6 tests failed
# # # 1 skipped test(s) detected. Consider enabling relevant config options=
 to improve coverage.
# # # Totals: pass:2 fail:3 xfail:0 xpass:0 skip:1 error:0
# # [FAIL]
# not ok 61 mkdirty # exit=3D1

Full log for that:

   https://lava.sirena.org.uk/scheduler/job/2106236#L6939

and I'm also seeing some LTP failures going into these commits that I'll
report separately.

bisect log for the futex test:

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
# good: [118eb2cb97b8fc0d515bb0449495959247db58f0] spi: bcm63xx: drop wrong=
 casts in probe()
# good: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] ASoC: Intel: avs: Honor =
NHLT override when setting up a path
# good: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] MAINTAINERS: refer to tr=
ivial-codec.yaml in relevant sections
# good: [059f545832be85d29ac9ccc416a16f647aa78485] spi: add support for mic=
rochip "soft" spi controller
# good: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] spi: spi-cadence: suppor=
ts transmission with bits_per_word of 16 and 32
# good: [e65b871c9b5af9265aefc5b8cd34993586d93aab] ASoC: codecs: pm4125: Re=
move irq_chip on component unbind
# good: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] firmware: cs_dsp: fix ke=
rnel-doc warnings in a header file
# good: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] ASoC: codecs: lpass-rx-m=
acro: add SM6115 compatible
# good: [123cd174a3782307787268adf45f22de4d290128] ASoC: Intel: atom: Repla=
ce strcpy() with strscpy()
# good: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] spi: dt-bindings: nuvoto=
n,npcm-pspi: Convert to DT schema
# good: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] ASoC: Intel: boards: fix=
 HDMI playback lookup when HDMI-In capture used
# good: [32172cf3cb543a04c41a1677c97a38e60cad05b6] ASoC: cs35l56: Allow res=
toring factory calibration through ALSA control
# good: [b3a5302484033331af37569f7277d00131694b57] ASoC: Intel: sof_rt5682:=
 Add quirk override support
# good: [873bc94689d832878befbcadc10b6ad5bb4e0027] ASoC: Intel: sof_sdw: ad=
d codec speaker support for the SKU
# good: [772ada50282b0c80343c8989147db816961f571d] ASoC: cs35l56: Alter err=
or codes for calibration routine
# good: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] regmap: sdw-mbq: Reorder=
 regmap_mbq_context struct for better packing
# good: [fb1ebb10468da414d57153ddebaab29c38ef1a78] regulator: core: disable=
 supply if enabling main regulator fails
# good: [2089f086303b773e181567fd8d5df3038bd85937] regulator: mt6363: Remov=
e unneeded semicolon
# good: [6951be397ca8b8b167c9f99b5a11c541148c38cb] ASoC: codecs: pm4125: re=
move duplicate code
# good: [4e92abd0a11b91af3742197a9ca962c3c00d0948] spi: imx: add i.MX51 ECS=
PI target mode support
# good: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] spi: fsl-qspi: support t=
he SpacemiT K1 SoC
# good: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] spi: imx: remove CLK cal=
culation and check for target mode
# good: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] regulator: pf9453: Fix k=
ernel doc for mux_poll()
# good: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] ASoC: SDCA: support Q7.8=
 volume format
# good: [3c36965df80801344850388592e95033eceea05b] regulator: Add support f=
or MediaTek MT6363 SPMI PMIC Regulators
# good: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] spi: aspeed: Use devm_io=
unmap() to unmap devm_ioremap() memory
# good: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] ASoC: dt-bindings: ti,pc=
m1862: convert to dtschema
# good: [655079ac8a7721ac215a0596e3f33b740e01144a] ASoC: qcom: q6asm: Use g=
uard() for spin locks
# good: [c4e68959af66df525d71db619ffe44af9178bb22] ASoC: dt-bindings: ti,ta=
s2781: Add TAS5822 support
# good: [380fd29d57abe6679d87ec56babe65ddc5873a37] spi: tegra210-quad: Chec=
k hardware status on timeout
# good: [af9c8092d84244ca54ffb590435735f788e7a170] regmap: i3c: Use ARRAY_S=
IZE()
# good: [84194c66aaf78fed150edb217b9f341518b1cba2] ASoC: codecs: aw88261: p=
ass pointer directly instead of passing the address
# good: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] regulator: Small cleanup=
 in of_get_regulation_constraints()
# good: [2ecc8c089802e033d2e5204d21a9f467e2517df9] regulator: pf9453: remov=
e unused I2C_LT register
# good: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] regcache: maple: Split -=
>populate() from ->init()
# good: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] ASoC: soc-core: check op=
s & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereference=
 error
# good: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] ASoC: max98090/91: fixin=
g the stream index
# good: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] spi: tle62x0: Add newlin=
e to sysfs attribute output
# good: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] ASoC: codec: wm8400: rep=
lace printk() calls with dev_*() device aware logging
# good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro: =
fix revision checking
# good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add suppor=
t for the external mclk
# good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove obso=
lete file entry in DIALOG SEMICONDUCTOR DRIVERS
# good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users about=
 uninitialized flat cache
# good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: make=
 use of common helpers
# good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `dep=
ends on` instead of `select`
# good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fail=
ure check for spacemit_i2s_init_dai()
# good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Suppo=
rt SPDIF output on A523 family
# good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID butt=
on IRQ
# good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: link=
 regulator inputs to supply groups
# good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspberry=
pi drivers depend on ARM
# good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI bu=
s support for cs530x parts
# good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace exec=
_op
# good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test: A=
dd test cases for cs_amp_set_efi_calibration_data()
# good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Cons=
tify struct fsi_stream_handler
# good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: add =
qrb2210-sndcard compatible string
# good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add nam=
e_prefix for rt1321 part id
# good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: addin=
g DAPM routing for digital output for max98091
# good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regulato=
r: Add RPMH regulator support for PMR735D
# good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fixin=
g a space
# good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: mak=
e qcom_spi_ecc_engine_ops_pipelined const
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
# good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS_E=
RR() vs NULL bug in probe()
# good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer must=
 be 0xff-ed before writing
# good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spellin=
g mistake "triming" -> "trimming"
# good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qcom:=
 Add Kaanapali LPASS macro codecs
# good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: support =
usage with simple-audio-card
# good: [fb25114cd760c13cf177d9ac37837fafcc9657b5] regulator: sy7636a: add =
gpios and input regulator
# good: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] ASoC: codecs: rt5670: us=
e SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
# good: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] regulator: rpmh-regulato=
r: Add RPMH regulator support for Glymur
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
# good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map ne=
cessary address window region
# good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Upda=
te ADMAIF bindings for tegra264
# good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the er=
ror of excessive semicolons
# good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-qp=
ic-snand: Add IPQ5332 compatible
# good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
# good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mode=
 support
# good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings: =
Convert Dialog DA9211 Regulators to DT schema
# good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offset=
 parameter
git bisect start 'fe4d0dea039f2befb93f27569593ec209843b0f5' 'ef96b7dd050abd=
62905588c41ffb397e0c9598c7' 'bd79452b39c21599e2cff42e9fbeb182656b6f6a' '21e=
68bcb1b0c688c2d9ca0d457922febac650ac1' '96498e804cb6629e02747336a0a33e49554=
49732' '4422df6782eb7aa9725a3c09d9ba3c38ecc85df4' '9e510e677090bb794b46348b=
10e1c8038286e00a' '118eb2cb97b8fc0d515bb0449495959247db58f0' 'd5c8b7902a416=
25ea328b52c78ebe750fbf6fef7' '6402ddf3027d8975f135cf2b2014d6bbeb2d3436' '05=
9f545832be85d29ac9ccc416a16f647aa78485' '4e00135b2dd1d7924a58bffa551b6ceb3b=
d836f2' 'e65b871c9b5af9265aefc5b8cd34993586d93aab' '8d63e85c5b50f1dbfa0ccb2=
14bd91fe5d7e2e860' '8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10' '123cd174a378=
2307787268adf45f22de4d290128' '1d562ba0aa7df81335bf96c02be77efe8d5bab87' '4=
d6e2211aeb932e096f673c88475016b1cc0f8ab' '32172cf3cb543a04c41a1677c97a38e60=
cad05b6' 'b3a5302484033331af37569f7277d00131694b57' '873bc94689d832878befbc=
adc10b6ad5bb4e0027' '772ada50282b0c80343c8989147db816961f571d' '6985defd1d8=
32f1dd9d1977a6a2cc2cef7632704' 'fb1ebb10468da414d57153ddebaab29c38ef1a78' '=
2089f086303b773e181567fd8d5df3038bd85937' '6951be397ca8b8b167c9f99b5a11c541=
148c38cb' '4e92abd0a11b91af3742197a9ca962c3c00d0948' 'abc9a349b87ac0fd3ba87=
87ca00971b59c2e1257' '55d03b5b5bdd04daf9a35ce49db18d8bb488dffb' '6bd1ad97eb=
790570c167d4de4ca59fbc9c33722a' '1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69' =
'3c36965df80801344850388592e95033eceea05b' '2f538ef9f6f7c3d700c68536f21447d=
fc598f8c8' 'aa897ffc396b48cc39eee133b6b43175d0df9eb5' '655079ac8a7721ac215a=
0596e3f33b740e01144a' 'c4e68959af66df525d71db619ffe44af9178bb22' '380fd29d5=
7abe6679d87ec56babe65ddc5873a37' 'af9c8092d84244ca54ffb590435735f788e7a170'=
 '84194c66aaf78fed150edb217b9f341518b1cba2' '252abf2d07d33b1c70a59ba1c9395b=
a42bbd793e' '2ecc8c089802e033d2e5204d21a9f467e2517df9' 'ed5d499b5c9cc11dd3e=
dae1a7a55db7dfa4f1bdc' 'e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0' 'f1dfbc1b=
5cf8650ae9a0d543e5f5335fc0f478ce' 'ecd0de438c1f0ee86cf8f6d5047965a2a181444b=
' '6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3' '20bcda681f8597e86070a4b3b12d1=
e4f541865d3' 'cf6bf51b53252284bafc7377a4d8dbf10f048b4d' '28039efa4d8e8bbf98=
b066133a906bd4e307d496' 'e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8' '8fdb030=
fe283c84fd8d378c97ad0f32d6cdec6ce' '66fecfa91deb536a12ddf3d878a99590d790027=
7' 'f034c16a4663eaf3198dc18b201ba50533fb5b81' '4a5ac6cd05a7e54f1585d7779464=
d6ed6272c134' 'ef042df96d0e1089764f39ede61bc8f140a4be00' '4c33cef58965eb655=
a0ac8e243aa323581ec025f' '01313661b248c5ba586acae09bff57077dbec0a5' 'e7434a=
df0c53a84d548226304cdb41c8818da1cb' '77a58ba7c64ccca20616aa03599766ccb0d1a3=
30' '4795375d8aa072e9aacb0b278e6203c6ca41816a' 'd29479abaded34b2b1dab2e17ef=
e96a65eba3d61' 'e973dfe9259095fb509ab12658c68d46f0e439d7' 'c17fa4cbc546c431=
ccf13e9354d5d9c1cd247b7c' '2528c15f314ece50218d1273654f630d74109583' 'd054c=
c3a2ccfb19484f3b54d69b6e416832dc8f4' '310bf433c01f78e0756fd5056a43118a2f773=
18c' 'fd5ef3d69f8975bad16c437a337b5cb04c8217a2' '638bae3fb225a708dc67db613a=
f62f6d14c4eff4' 'ecba655bf54a661ffe078856cd8dbc898270e4b5' '7e1906643a73745=
29af74b013bba35e4fa4e6ffc' 'd742ebcfe524dc54023f7c520d2ed2e4b7203c19' '6658=
472a3e2de08197acfe099ba71ee0e2505ecf' 'fce217449075d59b29052b8cdac567f0f3e2=
2641' '0cc08c8130ac8f74419f99fe707dc193b7f79d86' '0743acf746a81e0460a56fd5f=
f847d97fa7eb370' 'd77daa49085b067137d0adbe3263f75a7ee13a1b' '15afe57a874eaf=
104bfbb61ec598fa31627f7b19' '1e570e77392f43a3cdab2849d1f81535f8a033e2' 'fb2=
5114cd760c13cf177d9ac37837fafcc9657b5' '6621b0f118d500092f5f3d72ddddb22aeeb=
3c3a0' '65efe5404d151767653c7b7dd39bd2e7ad532c2d' '433e294c3c5b5d2020085a0e=
36c1cb47b694690a' '0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4' 'bf770d6d2097a=
52d87f4d9c88d0b05bd3998d7de' 'c2d420796a427dda71a2400909864e7f8e037fd4' '7e=
7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd' '64d87ccfae3326a9561fe41dc6073064a0=
83e0df' '4d410ba9aa275e7990a270f63ce436990ace1bea' '5e537031f322d55315cd384=
398b726a9a0748d47' '4412ab501677606436e5c49e41151a1e6eac7ac0' '9797329220a2=
c6622411eb9ecf6a35b24ce09d04' 'fe8cc44dd173cde5788ab4e3730ac61f3d316d9c' '6=
277a486a7faaa6c87f4bf1d59a2de233a093248' 'b83fb1b14c06bdd765903ac852ba20a14=
e24f227'
# test job: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] https://lava.sirena.=
org.uk/scheduler/job/2104091
# test job: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] https://lava.sirena.=
org.uk/scheduler/job/2104499
# test job: [96498e804cb6629e02747336a0a33e4955449732] https://lava.sirena.=
org.uk/scheduler/job/2099744
# test job: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] https://lava.sirena.=
org.uk/scheduler/job/2097747
# test job: [9e510e677090bb794b46348b10e1c8038286e00a] https://lava.sirena.=
org.uk/scheduler/job/2095684
# test job: [118eb2cb97b8fc0d515bb0449495959247db58f0] https://lava.sirena.=
org.uk/scheduler/job/2092525
# test job: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] https://lava.sirena.=
org.uk/scheduler/job/2092722
# test job: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] https://lava.sirena.=
org.uk/scheduler/job/2086597
# test job: [059f545832be85d29ac9ccc416a16f647aa78485] https://lava.sirena.=
org.uk/scheduler/job/2086754
# test job: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] https://lava.sirena.=
org.uk/scheduler/job/2082525
# test job: [e65b871c9b5af9265aefc5b8cd34993586d93aab] https://lava.sirena.=
org.uk/scheduler/job/2083134
# test job: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] https://lava.sirena.=
org.uk/scheduler/job/2082576
# test job: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] https://lava.sirena.=
org.uk/scheduler/job/2083116
# test job: [123cd174a3782307787268adf45f22de4d290128] https://lava.sirena.=
org.uk/scheduler/job/2078967
# test job: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] https://lava.sirena.=
org.uk/scheduler/job/2078346
# test job: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] https://lava.sirena.=
org.uk/scheduler/job/2078001
# test job: [32172cf3cb543a04c41a1677c97a38e60cad05b6] https://lava.sirena.=
org.uk/scheduler/job/2075073
# test job: [b3a5302484033331af37569f7277d00131694b57] https://lava.sirena.=
org.uk/scheduler/job/2074546
# test job: [873bc94689d832878befbcadc10b6ad5bb4e0027] https://lava.sirena.=
org.uk/scheduler/job/2074833
# test job: [772ada50282b0c80343c8989147db816961f571d] https://lava.sirena.=
org.uk/scheduler/job/2069152
# test job: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] https://lava.sirena.=
org.uk/scheduler/job/2059121
# test job: [fb1ebb10468da414d57153ddebaab29c38ef1a78] https://lava.sirena.=
org.uk/scheduler/job/2059787
# test job: [2089f086303b773e181567fd8d5df3038bd85937] https://lava.sirena.=
org.uk/scheduler/job/2058104
# test job: [6951be397ca8b8b167c9f99b5a11c541148c38cb] https://lava.sirena.=
org.uk/scheduler/job/2055777
# test job: [4e92abd0a11b91af3742197a9ca962c3c00d0948] https://lava.sirena.=
org.uk/scheduler/job/2055848
# test job: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] https://lava.sirena.=
org.uk/scheduler/job/2054637
# test job: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] https://lava.sirena.=
org.uk/scheduler/job/2053889
# test job: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] https://lava.sirena.=
org.uk/scheduler/job/2053541
# test job: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] https://lava.sirena.=
org.uk/scheduler/job/2053565
# test job: [3c36965df80801344850388592e95033eceea05b] https://lava.sirena.=
org.uk/scheduler/job/2049494
# test job: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] https://lava.sirena.=
org.uk/scheduler/job/2048656
# test job: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] https://lava.sirena.=
org.uk/scheduler/job/2048772
# test job: [655079ac8a7721ac215a0596e3f33b740e01144a] https://lava.sirena.=
org.uk/scheduler/job/2049697
# test job: [c4e68959af66df525d71db619ffe44af9178bb22] https://lava.sirena.=
org.uk/scheduler/job/2044037
# test job: [380fd29d57abe6679d87ec56babe65ddc5873a37] https://lava.sirena.=
org.uk/scheduler/job/2044746
# test job: [af9c8092d84244ca54ffb590435735f788e7a170] https://lava.sirena.=
org.uk/scheduler/job/2043671
# test job: [84194c66aaf78fed150edb217b9f341518b1cba2] https://lava.sirena.=
org.uk/scheduler/job/2038356
# test job: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] https://lava.sirena.=
org.uk/scheduler/job/2038551
# test job: [2ecc8c089802e033d2e5204d21a9f467e2517df9] https://lava.sirena.=
org.uk/scheduler/job/2038657
# test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.sirena.=
org.uk/scheduler/job/2029002
# test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.sirena.=
org.uk/scheduler/job/2026439
# test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.sirena.=
org.uk/scheduler/job/2025521
# test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.sirena.=
org.uk/scheduler/job/2026118
# test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.sirena.=
org.uk/scheduler/job/2025847
# test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.sirena.=
org.uk/scheduler/job/2022995
# test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.sirena.=
org.uk/scheduler/job/2023023
# test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.sirena.=
org.uk/scheduler/job/2020299
# test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.sirena.=
org.uk/scheduler/job/2020172
# test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.sirena.=
org.uk/scheduler/job/2021459
# test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.sirena.=
org.uk/scheduler/job/2015314
# test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.sirena.=
org.uk/scheduler/job/2015467
# test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.sirena.=
org.uk/scheduler/job/2011273
# test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.sirena.=
org.uk/scheduler/job/2010164
# test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.sirena.=
org.uk/scheduler/job/2009454
# test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.sirena.=
org.uk/scheduler/job/2008766
# test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.sirena.=
org.uk/scheduler/job/2007795
# test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.sirena.=
org.uk/scheduler/job/2007309
# test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.sirena.=
org.uk/scheduler/job/2009693
# test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.sirena.=
org.uk/scheduler/job/2008426
# test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.sirena.=
org.uk/scheduler/job/2008132
# test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.sirena.=
org.uk/scheduler/job/2000029
# test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.sirena.=
org.uk/scheduler/job/1997624
# test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.sirena.=
org.uk/scheduler/job/1995769
# test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.sirena.=
org.uk/scheduler/job/1996063
# test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.sirena.=
org.uk/scheduler/job/1996144
# test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.sirena.=
org.uk/scheduler/job/1991895
# test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.sirena.=
org.uk/scheduler/job/1985163
# test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.sirena.=
org.uk/scheduler/job/1978631
# test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.sirena.=
org.uk/scheduler/job/1975980
# test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.sirena.=
org.uk/scheduler/job/1975543
# test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.sirena.=
org.uk/scheduler/job/1975685
# test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.sirena.=
org.uk/scheduler/job/1965718
# test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.sirena.=
org.uk/scheduler/job/1964864
# test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.sirena.=
org.uk/scheduler/job/1962775
# test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.sirena.=
org.uk/scheduler/job/1962957
# test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.sirena.=
org.uk/scheduler/job/1962291
# test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.sirena.=
org.uk/scheduler/job/1960165
# test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.sirena.=
org.uk/scheduler/job/1959743
# test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.sirena.=
org.uk/scheduler/job/1959980
# test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.sirena.=
org.uk/scheduler/job/1957437
# test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.sirena.=
org.uk/scheduler/job/1957381
# test job: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] https://lava.sirena.=
org.uk/scheduler/job/1986562
# test job: [c2d420796a427dda71a2400909864e7f8e037fd4] https://lava.sirena.=
org.uk/scheduler/job/1986677
# test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.sirena.=
org.uk/scheduler/job/1954262
# test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.sirena.=
org.uk/scheduler/job/1947255
# test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.sirena.=
org.uk/scheduler/job/1947749
# test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.sirena.=
org.uk/scheduler/job/1946642
# test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.sirena.=
org.uk/scheduler/job/1946288
# test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.sirena.=
org.uk/scheduler/job/1947398
# test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.sirena.=
org.uk/scheduler/job/1946085
# test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.sirena.=
org.uk/scheduler/job/1947023
# test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.sirena.=
org.uk/scheduler/job/1946841
# test job: [fe4d0dea039f2befb93f27569593ec209843b0f5] https://lava.sirena.=
org.uk/scheduler/job/2106243
# bad: [fe4d0dea039f2befb93f27569593ec209843b0f5] Add linux-next specific f=
iles for 20251119
git bisect bad fe4d0dea039f2befb93f27569593ec209843b0f5
# test job: [c8e2262ce3e7658f7689975d66bbdecaf2cf95f9] https://lava.sirena.=
org.uk/scheduler/job/2106516
# bad: [c8e2262ce3e7658f7689975d66bbdecaf2cf95f9] Merge branch 'master' of =
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect bad c8e2262ce3e7658f7689975d66bbdecaf2cf95f9
# test job: [2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554] https://lava.sirena.=
org.uk/scheduler/job/2106588
# bad: [2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554] Merge branch 'fs-next' of=
 linux-next
git bisect bad 2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554
# test job: [f80c4f29e62d88f612101dc7addb0cc7a3bc628d] https://lava.sirena.=
org.uk/scheduler/job/2106622
# bad: [f80c4f29e62d88f612101dc7addb0cc7a3bc628d] Merge branch 'next' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git
git bisect bad f80c4f29e62d88f612101dc7addb0cc7a3bc628d
# test job: [b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed] https://lava.sirena.=
org.uk/scheduler/job/2106673
# bad: [b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed] Merge branch 'at91-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
git bisect bad b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed
# test job: [e92c9e71a82b75ce8297b60db4693af85ef4593b] https://lava.sirena.=
org.uk/scheduler/job/2106728
# bad: [e92c9e71a82b75ce8297b60db4693af85ef4593b] Merge branch 'mm-unstable=
' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad e92c9e71a82b75ce8297b60db4693af85ef4593b
# test job: [7d808bf13943f4c6a6142400bffe14267f6dc997] https://lava.sirena.=
org.uk/scheduler/job/2106774
# good: [7d808bf13943f4c6a6142400bffe14267f6dc997] mm/damon/tests/sysfs-kun=
it: handle alloc failures on damon_sysfs_test_add_targets()
git bisect good 7d808bf13943f4c6a6142400bffe14267f6dc997
# test job: [93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e] https://lava.sirena.=
org.uk/scheduler/job/2106827
# bad: [93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e] mm: vmstat: correct the c=
omment above preempt_disable_nested()
git bisect bad 93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e
# test job: [16cdd4e5a52b421b27b598b9eee3cd18212944a1] https://lava.sirena.=
org.uk/scheduler/job/2106960
# good: [16cdd4e5a52b421b27b598b9eee3cd18212944a1] migrate: optimise alloc_=
migration_target()
git bisect good 16cdd4e5a52b421b27b598b9eee3cd18212944a1
# test job: [3da23b1058cde436f5ab711f4597dbe75865ea38] https://lava.sirena.=
org.uk/scheduler/job/2107042
# bad: [3da23b1058cde436f5ab711f4597dbe75865ea38] tools/testing/selftests/m=
m: add smaps visibility guard region test
git bisect bad 3da23b1058cde436f5ab711f4597dbe75865ea38
# test job: [6b82275fdba27802ad7ec6910b86d83bea2dda8d] https://lava.sirena.=
org.uk/scheduler/job/2107095
# good: [6b82275fdba27802ad7ec6910b86d83bea2dda8d] mm: add atomic VMA flags=
 and set VM_MAYBE_GUARD as such
git bisect good 6b82275fdba27802ad7ec6910b86d83bea2dda8d
# test job: [b331f7745489548c5a020301f6f3b4aad20c7b77] https://lava.sirena.=
org.uk/scheduler/job/2107146
# bad: [b331f7745489548c5a020301f6f3b4aad20c7b77] mm: introduce copy-on-for=
k VMAs and make VM_MAYBE_GUARD one
git bisect bad b331f7745489548c5a020301f6f3b4aad20c7b77
# test job: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] https://lava.sirena.=
org.uk/scheduler/job/2107157
# good: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] mm: implement sticky VMA=
 flags
git bisect good f24f3801039f9a2033e3a2390fccc5adc00a8df7
# test job: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] https://lava.sirena.=
org.uk/scheduler/job/2107231
# bad: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] mm-implement-sticky-vma-f=
lags-fix-2
git bisect bad 2c91ae77d8fbafb153c13e554f50b7bbeef59d76
# test job: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] https://lava.sirena.=
org.uk/scheduler/job/2107257
# bad: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-implement-sticky-vma-f=
lags-fix
git bisect bad 79ee48c12ef8fe9a3daf0dbeda74f038a3f557be
# first bad commit: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-implement=
-sticky-vma-flags-fix

--HRdD9s9wZleQ0exp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkdvkAACgkQJNaLcl1U
h9DnRwf+OIfW5yMwW2KIJROT38TF/Q8GGNvgzlOWcHkQKfwmK1vK58hMR1C8HLvB
3j3rPj5Dy+WP7mhS0cy+izrY6R4O9jqjCVpba/dj9rfoTR9fIFZIFLbXTVp2ziUM
W4do2wa9wptBUMx0E111/tlfS8/gx448gNXLRLmCitMmp1rAgbP+jp4kw52SIGaB
alJYR6kUyS67c4gB9czzzU8nENSwUdKv0XJ9QKiaKoc6OTh9FB4kCJ09APEf0WB3
ZPY/cl4mxyAPYfhAUhVh2lHi51VqMwuHYlDDnSgtZtPUE22ors1RrV33hICgSVUb
Kpq1cdJwzvV2tT15iyuZ7RPEsPdTmg==
=znyE
-----END PGP SIGNATURE-----

--HRdD9s9wZleQ0exp--

