Return-Path: <linux-fsdevel+bounces-69845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF834C8750C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 23:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E3C3B5185
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95972FFF9B;
	Tue, 25 Nov 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Q2AeoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BF2EBB8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764109844; cv=none; b=V19N6PYPtEoKn0XOqT0LpFOxG4xuhQHSrKo/EBvGkWNGrYPqjjimGPlbgt4WXxsYVIUuGIrwwxvIlIt7zpuKEwXXHUNnagBk2sVaYbfhgTAOE0e9gKFSNJJFwpxGNaymOmUmK1KttW4FgL7Q6RXrkNaTAwkIEU4SDvUSkdGhpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764109844; c=relaxed/simple;
	bh=K6LG9d1YIVjC13vzQKBziI30mFGI6z1WN+Kty2Gr7iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpelfRXO3FXL6aTCf1Ypf2TUHZrbc9KJpJIyEHNMBRzDBRosu4XGk7jJzMFlRru43GGv4wjsN3nns6s77UpR5CMOVlWxCu/XyDxRScIBS8p1O2hQmyjCv6YpfmB4svojnaFjGlAs1jeV74H46nz0zSm49U3Mnmt4SlhFZV0gmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Q2AeoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E90C4CEF1;
	Tue, 25 Nov 2025 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764109843;
	bh=K6LG9d1YIVjC13vzQKBziI30mFGI6z1WN+Kty2Gr7iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0Q2AeoTjXQ87W8ik3qdsX3awNlRSjzbh8k2wZ96grKp6uVDENCtBcK9Y8xqeHTxZ
	 0nABM5oRUTKhlfqkvXRhkzQokEP/2OhSK0+u7GFv01Hg5FxhgR26VIJ6+9g/y7cQ8D
	 6rU80qwVJ/oqXj4ANro0CZfGgnyeGD+V5Q2XRSl93QRNlQaUoR8U8Z2TqFCZceLLnm
	 Hb/segTO+DhAB9hsNUeF3SJrXP3mZnm21RdS3m4Y1hJA8lOiKnXXai7brpvTxLgNNg
	 8Cv1ysdXIa0escyEuFyExT5AgRWPi2eR3p0iOz1qDLS9hnBWltPqtGuk+d16v15Gpp
	 M/+exDd0JAqFA==
Date: Tue, 25 Nov 2025 22:30:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 22/47] ipc: convert do_mq_open() to FD_PREPARE()
Message-ID: <c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3IwkfWdB+QMMglL3"
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org>
X-Cookie: Stamp out philately.


--3IwkfWdB+QMMglL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 05:33:40PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I'm seeing a regression in -next in the LTP mq_open01 test which bisects
to this commit:

tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc7-next-20251125 #1 SMP PREE=
MPT @1764061327 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 24s
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:255: TPASS: NORMAL returned: 4: SUCCESS (0)
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:255: TPASS: NORMAL returned: 4: SUCCESS (0)
mq_open01.c:226: TINFO: queue name "/caaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
mq_open01.c:255: TPASS: NORMAL returned: 4: SUCCESS (0)
mq_open01.c:226: TINFO: queue name "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
mq_open01.c:272: TPASS: NORMAL returned: -1: ENAMETOOLONG (36)
mq_open01.c:226: TINFO: queue name ""
mq_open01.c:272: TPASS: NORMAL returned: -1: EINVAL (22)
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:272: TPASS: NORMAL returned: -1: EACCES (13)
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:272: TPASS: NORMAL returned: -1: EEXIST (17)
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:272: TPASS: NO_FILE returned: -1: EMFILE (24)
mq_open01.c:226: TINFO: queue name "/notexist"
mq_open01.c:272: TPASS: NORMAL returned: -1: ENOENT (2)
mq_open01.c:226: TINFO: queue name "/test_mqueue"
mq_open01.c:263: TFAIL: NO_SPACE expected errno: 13: EACCES (13)

which bisect to this patch.  It's not clear to me if this is an overly
sensitive test or an actual issue.

BTW I do note that the subject says FD_PREPARE() but the patch uses
FD_ADD().

bisect log, including links to full logs from test jobs:

# bad: [92fd6e84175befa1775e5c0ab682938eca27c0b2] Add linux-next specific f=
iles for 20251125
# good: [07e9a68478302d35f3372ac8c9994d679a9cfdca] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [cb99656b7c4185953c9d272bbdab63c8aa651e6e] spi: Fix potential unini=
tialized variable in probe()
# good: [df919994d323c7c86e32fa2745730136d58ada12] ASoC: Intel: avs: Replac=
e snprintf() with scnprintf()
# good: [670500b41e543c5cb09eb9f7f0e4e26c5b5fdf7e] regulator: pca9450: Fix =
error code in probe()
# good: [f1c668269ded16bea32a11d03f4584caa0c018c9] regulator: qcomm-labibb:=
 replace use of system_wq with system_dfl_wq
# good: [3efee7362dbf896072af1c1aaeaf9fd6e235c591] ASoC: SDCA: Add stubs fo=
r FDL helper functions
# good: [43a3adb6dd39d98bf84e04569e7604be5e5c0d79] spi: spidev: add compati=
ble for arduino spi mcu interface
# good: [3af1815a2f9caebfc666af3912e24d030a5368d5] ASoC: SDCA: Add basic SD=
CA function driver
# good: [33822d795ab93067d9a65f42003c0d01c65d4a9d] ASoC: cs35l56: Use SND_S=
OC_BYTES_E_ACC() for CAL_DATA_RB control
# good: [d5089fffe1db04a802b028c2ef4875be1ed452a3] ASoC: tas2781: Add tas25=
68/2574/5806m/5806md/5830 support
# good: [12d821bd13d42e6de3ecb1c13918b1f06a3ee213] regulator: Add FP9931/JD=
9930 driver
# good: [3045e29d248bde2a68da425498a656093ee0df69] firmware: cs_dsp: Append=
 \n to debugfs string during read
# good: [bdf96e9135a0cf53a853a19c30fa11131a744062] ASoC: codecs: lpass-rx-m=
acro: fix mute_stream affecting all paths
# good: [b871d9adffe5a64a1fd9edcb1aebbcc995b17901] regulator: make the subs=
ystem aware of shared GPIOs
# good: [e2c48498a93404743e0565dcac29450fec02e6a3] ASoC: soc-core: Pre-chec=
k zero CPU/codec DAIs, handle early rtd->dais alloc failure
# good: [7a0a87712120329c034b0aae88bdaa05bd046f10] ASoC: wsa883x: drop GPIO=
D_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
# good: [d9813cd23d5a7b254cc1b1c1ea042634d8da62e6] spi: sophgo: Fix incorre=
ct use of bus width value macros
# good: [e45979641a9a9dbb48fc77c5b36a5091a92e7227] ASoC: SOF: sof-client-pr=
obes: Replace snprintf() with scnprintf()
# good: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] regulator: renesas-usb-v=
bus-regulator: Remove unused headers
# good: [d218ea171430e49412804efb794942dd121a8032] ASoC: mediatek: mt8189: =
add machine driver with nau8825
# good: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] MAINTAINERS: adjust file=
 entry in RISC-V MICROCHIP SUPPORT
# good: [96498e804cb6629e02747336a0a33e4955449732] spi: davinci: remove pla=
tform data header
# good: [ab61de9b78dda140573fb474af65f0e1ae13ff5b] mm/migrate, swap: drop u=
sage of folio_index
# good: [0a63a0e7570b9b2631dfb8d836dc572709dce39e] mm/damon/tests/vaddr-kun=
it: handle alloc failures on damon_test_split_evenly_succ()
# good: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] ASoC: ux500: mop500_ab85=
00: convert to snd_soc_dapm_xxx()
# good: [9e510e677090bb794b46348b10e1c8038286e00a] spi: aspeed: Add support=
 for the AST2700 SPI controller
# good: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] ASoC: Intel: avs: Honor =
NHLT override when setting up a path
# good: [118eb2cb97b8fc0d515bb0449495959247db58f0] spi: bcm63xx: drop wrong=
 casts in probe()
# good: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] MAINTAINERS: refer to tr=
ivial-codec.yaml in relevant sections
# good: [059f545832be85d29ac9ccc416a16f647aa78485] spi: add support for mic=
rochip "soft" spi controller
# good: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] ASoC: codecs: lpass-rx-m=
acro: add SM6115 compatible
# good: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] spi: spi-cadence: suppor=
ts transmission with bits_per_word of 16 and 32
# good: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] firmware: cs_dsp: fix ke=
rnel-doc warnings in a header file
# good: [e65b871c9b5af9265aefc5b8cd34993586d93aab] ASoC: codecs: pm4125: Re=
move irq_chip on component unbind
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
# good: [6951be397ca8b8b167c9f99b5a11c541148c38cb] ASoC: codecs: pm4125: re=
move duplicate code
# good: [2089f086303b773e181567fd8d5df3038bd85937] regulator: mt6363: Remov=
e unneeded semicolon
# good: [4e92abd0a11b91af3742197a9ca962c3c00d0948] spi: imx: add i.MX51 ECS=
PI target mode support
# good: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] spi: fsl-qspi: support t=
he SpacemiT K1 SoC
# good: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] spi: imx: remove CLK cal=
culation and check for target mode
# good: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] ASoC: SDCA: support Q7.8=
 volume format
# good: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] regulator: pf9453: Fix k=
ernel doc for mux_poll()
# good: [3c36965df80801344850388592e95033eceea05b] regulator: Add support f=
or MediaTek MT6363 SPMI PMIC Regulators
# good: [655079ac8a7721ac215a0596e3f33b740e01144a] ASoC: qcom: q6asm: Use g=
uard() for spin locks
# good: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] ASoC: dt-bindings: ti,pc=
m1862: convert to dtschema
# good: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] spi: aspeed: Use devm_io=
unmap() to unmap devm_ioremap() memory
# good: [c4e68959af66df525d71db619ffe44af9178bb22] ASoC: dt-bindings: ti,ta=
s2781: Add TAS5822 support
# good: [af9c8092d84244ca54ffb590435735f788e7a170] regmap: i3c: Use ARRAY_S=
IZE()
# good: [380fd29d57abe6679d87ec56babe65ddc5873a37] spi: tegra210-quad: Chec=
k hardware status on timeout
# good: [a4438f06b1db15ce3d831ce82b8767665638aa2a] PCI/TSM: Report active I=
DE streams
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
# good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add suppor=
t for the external mclk
# good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro: =
fix revision checking
# good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: make=
 use of common helpers
# good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove obso=
lete file entry in DIALOG SEMICONDUCTOR DRIVERS
# good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users about=
 uninitialized flat cache
# good: [62fb11fba0cc12ecb808fc57b16027b94bd1ba1a] arm64: dts: renesas: rzt=
2h/rzn2h-evk: Enable ADCs
# good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `dep=
ends on` instead of `select`
# good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fail=
ure check for spacemit_i2s_init_dai()
# good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Suppo=
rt SPDIF output on A523 family
# good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: link=
 regulator inputs to supply groups
# good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID butt=
on IRQ
# good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test: A=
dd test cases for cs_amp_set_efi_calibration_data()
# good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Cons=
tify struct fsi_stream_handler
# good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspberry=
pi drivers depend on ARM
# good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: add =
qrb2210-sndcard compatible string
# good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI bu=
s support for cs530x parts
# good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace exec=
_op
# good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add nam=
e_prefix for rt1321 part id
# good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: addin=
g DAPM routing for digital output for max98091
# good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regulato=
r: Add RPMH regulator support for PMR735D
# good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: mak=
e qcom_spi_ecc_engine_ops_pipelined const
# good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fixin=
g a space
# good: [638bae3fb225a708dc67db613af62f6d14c4eff4] ASoC: max98090/91: added=
 DAPM widget for digital output for max98091
# good: [32200f4828de9d7e6db379909898e718747f4e18] soc: amlogic: canvas: fi=
x device leak on lookup
# good: [ecba655bf54a661ffe078856cd8dbc898270e4b5] ASoC: fsl_aud2htx: add I=
EC958_SUBFRAME_LE format in supported list
# good: [7e1906643a7374529af74b013bba35e4fa4e6ffc] ASoC: codecs: va-macro: =
Clean up on error path in probe()
# good: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] ASoC: soc.h: remove snd_=
soc_kcontrol_component()
# good: [fce217449075d59b29052b8cdac567f0f3e22641] ASoC: spacemit: add i2s =
support for K1 SoC
# good: [6658472a3e2de08197acfe099ba71ee0e2505ecf] ASoC: amd: amd_sdw: Prop=
agate the PCI subsystem Vendor and Device IDs
# good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS_E=
RR() vs NULL bug in probe()
# good: [e8fd8080e7a9c8c577e5dec5bd6d486a3f14011c] media: i2c: max96717: Us=
e %pe format specifier
# good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer must=
 be 0xff-ed before writing
# good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: support =
usage with simple-audio-card
# good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spellin=
g mistake "triming" -> "trimming"
# good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qcom:=
 Add Kaanapali LPASS macro codecs
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
# good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
# good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mode=
 support
# good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Upda=
te ADMAIF bindings for tegra264
# good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map ne=
cessary address window region
# good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings: =
Convert Dialog DA9211 Regulators to DT schema
# good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offset=
 parameter
# good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the er=
ror of excessive semicolons
# good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-qp=
ic-snand: Add IPQ5332 compatible
# good: [7e1fe102c8517a402327c37685357fbe279b3278] drm/xe/guc: Track pendin=
g-enable source in submission state
# good: [cc7e1a9b596c9d9dc3324c056cf8162e9fca2765] drm/i915/irq: duplicate =
HAS_FBC() for irq error mask usage
# good: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] Merge branch 'next/drive=
rs' into for-next
git bisect start '92fd6e84175befa1775e5c0ab682938eca27c0b2' '07e9a68478302d=
35f3372ac8c9994d679a9cfdca' 'cb99656b7c4185953c9d272bbdab63c8aa651e6e' 'df9=
19994d323c7c86e32fa2745730136d58ada12' '670500b41e543c5cb09eb9f7f0e4e26c5b5=
fdf7e' 'f1c668269ded16bea32a11d03f4584caa0c018c9' '3efee7362dbf896072af1c1a=
aeaf9fd6e235c591' '43a3adb6dd39d98bf84e04569e7604be5e5c0d79' '3af1815a2f9ca=
ebfc666af3912e24d030a5368d5' '33822d795ab93067d9a65f42003c0d01c65d4a9d' 'd5=
089fffe1db04a802b028c2ef4875be1ed452a3' '12d821bd13d42e6de3ecb1c13918b1f06a=
3ee213' '3045e29d248bde2a68da425498a656093ee0df69' 'bdf96e9135a0cf53a853a19=
c30fa11131a744062' 'b871d9adffe5a64a1fd9edcb1aebbcc995b17901' 'e2c48498a934=
04743e0565dcac29450fec02e6a3' '7a0a87712120329c034b0aae88bdaa05bd046f10' 'd=
9813cd23d5a7b254cc1b1c1ea042634d8da62e6' 'e45979641a9a9dbb48fc77c5b36a5091a=
92e7227' '21e68bcb1b0c688c2d9ca0d457922febac650ac1' 'd218ea171430e49412804e=
fb794942dd121a8032' 'bd79452b39c21599e2cff42e9fbeb182656b6f6a' '96498e804cb=
6629e02747336a0a33e4955449732' 'ab61de9b78dda140573fb474af65f0e1ae13ff5b' '=
0a63a0e7570b9b2631dfb8d836dc572709dce39e' '4422df6782eb7aa9725a3c09d9ba3c38=
ecc85df4' '9e510e677090bb794b46348b10e1c8038286e00a' 'd5c8b7902a41625ea328b=
52c78ebe750fbf6fef7' '118eb2cb97b8fc0d515bb0449495959247db58f0' '6402ddf302=
7d8975f135cf2b2014d6bbeb2d3436' '059f545832be85d29ac9ccc416a16f647aa78485' =
'8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10' '4e00135b2dd1d7924a58bffa551b6ce=
b3bd836f2' '8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860' 'e65b871c9b5af9265aef=
c5b8cd34993586d93aab' '123cd174a3782307787268adf45f22de4d290128' '1d562ba0a=
a7df81335bf96c02be77efe8d5bab87' '4d6e2211aeb932e096f673c88475016b1cc0f8ab'=
 '32172cf3cb543a04c41a1677c97a38e60cad05b6' 'b3a5302484033331af37569f7277d0=
0131694b57' '873bc94689d832878befbcadc10b6ad5bb4e0027' '772ada50282b0c80343=
c8989147db816961f571d' '6985defd1d832f1dd9d1977a6a2cc2cef7632704' 'fb1ebb10=
468da414d57153ddebaab29c38ef1a78' '6951be397ca8b8b167c9f99b5a11c541148c38cb=
' '2089f086303b773e181567fd8d5df3038bd85937' '4e92abd0a11b91af3742197a9ca96=
2c3c00d0948' 'abc9a349b87ac0fd3ba8787ca00971b59c2e1257' '55d03b5b5bdd04daf9=
a35ce49db18d8bb488dffb' '1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69' '6bd1ad9=
7eb790570c167d4de4ca59fbc9c33722a' '3c36965df80801344850388592e95033eceea05=
b' '655079ac8a7721ac215a0596e3f33b740e01144a' 'aa897ffc396b48cc39eee133b6b4=
3175d0df9eb5' '2f538ef9f6f7c3d700c68536f21447dfc598f8c8' 'c4e68959af66df525=
d71db619ffe44af9178bb22' 'af9c8092d84244ca54ffb590435735f788e7a170' '380fd2=
9d57abe6679d87ec56babe65ddc5873a37' 'a4438f06b1db15ce3d831ce82b8767665638aa=
2a' '84194c66aaf78fed150edb217b9f341518b1cba2' '252abf2d07d33b1c70a59ba1c93=
95ba42bbd793e' '2ecc8c089802e033d2e5204d21a9f467e2517df9' 'ed5d499b5c9cc11d=
d3edae1a7a55db7dfa4f1bdc' 'e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0' 'f1dfb=
c1b5cf8650ae9a0d543e5f5335fc0f478ce' 'ecd0de438c1f0ee86cf8f6d5047965a2a1814=
44b' '6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3' 'cf6bf51b53252284bafc7377a4=
d8dbf10f048b4d' '20bcda681f8597e86070a4b3b12d1e4f541865d3' '8fdb030fe283c84=
fd8d378c97ad0f32d6cdec6ce' '28039efa4d8e8bbf98b066133a906bd4e307d496' 'e062=
bdfdd6adbb2dee7751d054c1d8df63ddb8b8' '62fb11fba0cc12ecb808fc57b16027b94bd1=
ba1a' '66fecfa91deb536a12ddf3d878a99590d7900277' 'f034c16a4663eaf3198dc18b2=
01ba50533fb5b81' '4a5ac6cd05a7e54f1585d7779464d6ed6272c134' '4c33cef58965eb=
655a0ac8e243aa323581ec025f' 'ef042df96d0e1089764f39ede61bc8f140a4be00' '479=
5375d8aa072e9aacb0b278e6203c6ca41816a' 'd29479abaded34b2b1dab2e17efe96a65eb=
a3d61' '01313661b248c5ba586acae09bff57077dbec0a5' 'e973dfe9259095fb509ab126=
58c68d46f0e439d7' 'e7434adf0c53a84d548226304cdb41c8818da1cb' '77a58ba7c64cc=
ca20616aa03599766ccb0d1a330' 'c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c' '25=
28c15f314ece50218d1273654f630d74109583' 'd054cc3a2ccfb19484f3b54d69b6e41683=
2dc8f4' 'fd5ef3d69f8975bad16c437a337b5cb04c8217a2' '310bf433c01f78e0756fd50=
56a43118a2f77318c' '638bae3fb225a708dc67db613af62f6d14c4eff4' '32200f4828de=
9d7e6db379909898e718747f4e18' 'ecba655bf54a661ffe078856cd8dbc898270e4b5' '7=
e1906643a7374529af74b013bba35e4fa4e6ffc' 'd742ebcfe524dc54023f7c520d2ed2e4b=
7203c19' 'fce217449075d59b29052b8cdac567f0f3e22641' '6658472a3e2de08197acfe=
099ba71ee0e2505ecf' '0cc08c8130ac8f74419f99fe707dc193b7f79d86' 'e8fd8080e7a=
9c8c577e5dec5bd6d486a3f14011c' '0743acf746a81e0460a56fd5ff847d97fa7eb370' '=
1e570e77392f43a3cdab2849d1f81535f8a033e2' 'd77daa49085b067137d0adbe3263f75a=
7ee13a1b' '15afe57a874eaf104bfbb61ec598fa31627f7b19' 'fb25114cd760c13cf177d=
9ac37837fafcc9657b5' '6621b0f118d500092f5f3d72ddddb22aeeb3c3a0' '65efe5404d=
151767653c7b7dd39bd2e7ad532c2d' '433e294c3c5b5d2020085a0e36c1cb47b694690a' =
'0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4' 'bf770d6d2097a52d87f4d9c88d0b05b=
d3998d7de' 'c2d420796a427dda71a2400909864e7f8e037fd4' '7e7e2c6e2a1cb250f8d0=
3bb99eed01f6d982d5dd' '9797329220a2c6622411eb9ecf6a35b24ce09d04' 'fe8cc44dd=
173cde5788ab4e3730ac61f3d316d9c' '4d410ba9aa275e7990a270f63ce436990ace1bea'=
 '64d87ccfae3326a9561fe41dc6073064a083e0df' '6277a486a7faaa6c87f4bf1d59a2de=
233a093248' 'b83fb1b14c06bdd765903ac852ba20a14e24f227' '5e537031f322d55315c=
d384398b726a9a0748d47' '4412ab501677606436e5c49e41151a1e6eac7ac0' '7e1fe102=
c8517a402327c37685357fbe279b3278' 'cc7e1a9b596c9d9dc3324c056cf8162e9fca2765=
' '6c177775dcc5e70a64ddf4ee842c66af498f2c7c'
# test job: [cb99656b7c4185953c9d272bbdab63c8aa651e6e] https://lava.sirena.=
org.uk/scheduler/job/2132768
# test job: [df919994d323c7c86e32fa2745730136d58ada12] https://lava.sirena.=
org.uk/scheduler/job/2121675
# test job: [670500b41e543c5cb09eb9f7f0e4e26c5b5fdf7e] https://lava.sirena.=
org.uk/scheduler/job/2121060
# test job: [f1c668269ded16bea32a11d03f4584caa0c018c9] https://lava.sirena.=
org.uk/scheduler/job/2113575
# test job: [3efee7362dbf896072af1c1aaeaf9fd6e235c591] https://lava.sirena.=
org.uk/scheduler/job/2115151
# test job: [43a3adb6dd39d98bf84e04569e7604be5e5c0d79] https://lava.sirena.=
org.uk/scheduler/job/2115059
# test job: [3af1815a2f9caebfc666af3912e24d030a5368d5] https://lava.sirena.=
org.uk/scheduler/job/2115418
# test job: [33822d795ab93067d9a65f42003c0d01c65d4a9d] https://lava.sirena.=
org.uk/scheduler/job/2112462
# test job: [d5089fffe1db04a802b028c2ef4875be1ed452a3] https://lava.sirena.=
org.uk/scheduler/job/2111808
# test job: [12d821bd13d42e6de3ecb1c13918b1f06a3ee213] https://lava.sirena.=
org.uk/scheduler/job/2112910
# test job: [3045e29d248bde2a68da425498a656093ee0df69] https://lava.sirena.=
org.uk/scheduler/job/2111757
# test job: [bdf96e9135a0cf53a853a19c30fa11131a744062] https://lava.sirena.=
org.uk/scheduler/job/2109772
# test job: [b871d9adffe5a64a1fd9edcb1aebbcc995b17901] https://lava.sirena.=
org.uk/scheduler/job/2107869
# test job: [e2c48498a93404743e0565dcac29450fec02e6a3] https://lava.sirena.=
org.uk/scheduler/job/2107331
# test job: [7a0a87712120329c034b0aae88bdaa05bd046f10] https://lava.sirena.=
org.uk/scheduler/job/2107505
# test job: [d9813cd23d5a7b254cc1b1c1ea042634d8da62e6] https://lava.sirena.=
org.uk/scheduler/job/2105371
# test job: [e45979641a9a9dbb48fc77c5b36a5091a92e7227] https://lava.sirena.=
org.uk/scheduler/job/2104424
# test job: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] https://lava.sirena.=
org.uk/scheduler/job/2104496
# test job: [d218ea171430e49412804efb794942dd121a8032] https://lava.sirena.=
org.uk/scheduler/job/2104281
# test job: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] https://lava.sirena.=
org.uk/scheduler/job/2104080
# test job: [96498e804cb6629e02747336a0a33e4955449732] https://lava.sirena.=
org.uk/scheduler/job/2099775
# test job: [ab61de9b78dda140573fb474af65f0e1ae13ff5b] https://lava.sirena.=
org.uk/scheduler/job/2107135
# test job: [0a63a0e7570b9b2631dfb8d836dc572709dce39e] https://lava.sirena.=
org.uk/scheduler/job/2107227
# test job: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] https://lava.sirena.=
org.uk/scheduler/job/2097769
# test job: [9e510e677090bb794b46348b10e1c8038286e00a] https://lava.sirena.=
org.uk/scheduler/job/2093926
# test job: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] https://lava.sirena.=
org.uk/scheduler/job/2092750
# test job: [118eb2cb97b8fc0d515bb0449495959247db58f0] https://lava.sirena.=
org.uk/scheduler/job/2092501
# test job: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] https://lava.sirena.=
org.uk/scheduler/job/2086626
# test job: [059f545832be85d29ac9ccc416a16f647aa78485] https://lava.sirena.=
org.uk/scheduler/job/2086745
# test job: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] https://lava.sirena.=
org.uk/scheduler/job/2083097
# test job: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] https://lava.sirena.=
org.uk/scheduler/job/2082513
# test job: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] https://lava.sirena.=
org.uk/scheduler/job/2082647
# test job: [e65b871c9b5af9265aefc5b8cd34993586d93aab] https://lava.sirena.=
org.uk/scheduler/job/2083140
# test job: [123cd174a3782307787268adf45f22de4d290128] https://lava.sirena.=
org.uk/scheduler/job/2078931
# test job: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] https://lava.sirena.=
org.uk/scheduler/job/2078338
# test job: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] https://lava.sirena.=
org.uk/scheduler/job/2078005
# test job: [32172cf3cb543a04c41a1677c97a38e60cad05b6] https://lava.sirena.=
org.uk/scheduler/job/2075070
# test job: [b3a5302484033331af37569f7277d00131694b57] https://lava.sirena.=
org.uk/scheduler/job/2074541
# test job: [873bc94689d832878befbcadc10b6ad5bb4e0027] https://lava.sirena.=
org.uk/scheduler/job/2074811
# test job: [772ada50282b0c80343c8989147db816961f571d] https://lava.sirena.=
org.uk/scheduler/job/2069227
# test job: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] https://lava.sirena.=
org.uk/scheduler/job/2059096
# test job: [fb1ebb10468da414d57153ddebaab29c38ef1a78] https://lava.sirena.=
org.uk/scheduler/job/2059791
# test job: [6951be397ca8b8b167c9f99b5a11c541148c38cb] https://lava.sirena.=
org.uk/scheduler/job/2055762
# test job: [2089f086303b773e181567fd8d5df3038bd85937] https://lava.sirena.=
org.uk/scheduler/job/2058088
# test job: [4e92abd0a11b91af3742197a9ca962c3c00d0948] https://lava.sirena.=
org.uk/scheduler/job/2055840
# test job: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] https://lava.sirena.=
org.uk/scheduler/job/2054599
# test job: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] https://lava.sirena.=
org.uk/scheduler/job/2053852
# test job: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] https://lava.sirena.=
org.uk/scheduler/job/2053505
# test job: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] https://lava.sirena.=
org.uk/scheduler/job/2053466
# test job: [3c36965df80801344850388592e95033eceea05b] https://lava.sirena.=
org.uk/scheduler/job/2049477
# test job: [655079ac8a7721ac215a0596e3f33b740e01144a] https://lava.sirena.=
org.uk/scheduler/job/2049691
# test job: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] https://lava.sirena.=
org.uk/scheduler/job/2048778
# test job: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] https://lava.sirena.=
org.uk/scheduler/job/2048662
# test job: [c4e68959af66df525d71db619ffe44af9178bb22] https://lava.sirena.=
org.uk/scheduler/job/2044045
# test job: [af9c8092d84244ca54ffb590435735f788e7a170] https://lava.sirena.=
org.uk/scheduler/job/2043672
# test job: [380fd29d57abe6679d87ec56babe65ddc5873a37] https://lava.sirena.=
org.uk/scheduler/job/2044567
# test job: [a4438f06b1db15ce3d831ce82b8767665638aa2a] https://lava.sirena.=
org.uk/scheduler/job/2081108
# test job: [84194c66aaf78fed150edb217b9f341518b1cba2] https://lava.sirena.=
org.uk/scheduler/job/2038363
# test job: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] https://lava.sirena.=
org.uk/scheduler/job/2038539
# test job: [2ecc8c089802e033d2e5204d21a9f467e2517df9] https://lava.sirena.=
org.uk/scheduler/job/2038647
# test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.sirena.=
org.uk/scheduler/job/2029010
# test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.sirena.=
org.uk/scheduler/job/2026440
# test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.sirena.=
org.uk/scheduler/job/2025486
# test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.sirena.=
org.uk/scheduler/job/2026128
# test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.sirena.=
org.uk/scheduler/job/2025859
# test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.sirena.=
org.uk/scheduler/job/2022941
# test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.sirena.=
org.uk/scheduler/job/2022962
# test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.sirena.=
org.uk/scheduler/job/2021463
# test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.sirena.=
org.uk/scheduler/job/2020286
# test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.sirena.=
org.uk/scheduler/job/2020185
# test job: [62fb11fba0cc12ecb808fc57b16027b94bd1ba1a] https://lava.sirena.=
org.uk/scheduler/job/2106794
# test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.sirena.=
org.uk/scheduler/job/2015341
# test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.sirena.=
org.uk/scheduler/job/2015423
# test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.sirena.=
org.uk/scheduler/job/2011278
# test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.sirena.=
org.uk/scheduler/job/2009453
# test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.sirena.=
org.uk/scheduler/job/2010152
# test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.sirena.=
org.uk/scheduler/job/2009687
# test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.sirena.=
org.uk/scheduler/job/2008427
# test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.sirena.=
org.uk/scheduler/job/2008854
# test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.sirena.=
org.uk/scheduler/job/2008111
# test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.sirena.=
org.uk/scheduler/job/2007797
# test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.sirena.=
org.uk/scheduler/job/2007347
# test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.sirena.=
org.uk/scheduler/job/2004856
# test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.sirena.=
org.uk/scheduler/job/1997633
# test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.sirena.=
org.uk/scheduler/job/1995736
# test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.sirena.=
org.uk/scheduler/job/1996130
# test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.sirena.=
org.uk/scheduler/job/1996059
# test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.sirena.=
org.uk/scheduler/job/1991850
# test job: [32200f4828de9d7e6db379909898e718747f4e18] https://lava.sirena.=
org.uk/scheduler/job/2106716
# test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.sirena.=
org.uk/scheduler/job/1985174
# test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.sirena.=
org.uk/scheduler/job/1978628
# test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.sirena.=
org.uk/scheduler/job/1975988
# test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.sirena.=
org.uk/scheduler/job/1975641
# test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.sirena.=
org.uk/scheduler/job/1973472
# test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.sirena.=
org.uk/scheduler/job/1965714
# test job: [e8fd8080e7a9c8c577e5dec5bd6d486a3f14011c] https://lava.sirena.=
org.uk/scheduler/job/1978820
# test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.sirena.=
org.uk/scheduler/job/1964870
# test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.sirena.=
org.uk/scheduler/job/1962304
# test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.sirena.=
org.uk/scheduler/job/1964717
# test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.sirena.=
org.uk/scheduler/job/1962971
# test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.sirena.=
org.uk/scheduler/job/1961714
# test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.sirena.=
org.uk/scheduler/job/1959760
# test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.sirena.=
org.uk/scheduler/job/1959953
# test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.sirena.=
org.uk/scheduler/job/1957700
# test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.sirena.=
org.uk/scheduler/job/1957382
# test job: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] https://lava.sirena.=
org.uk/scheduler/job/1984502
# test job: [c2d420796a427dda71a2400909864e7f8e037fd4] https://lava.sirena.=
org.uk/scheduler/job/1984566
# test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.sirena.=
org.uk/scheduler/job/1957243
# test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.sirena.=
org.uk/scheduler/job/1947384
# test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.sirena.=
org.uk/scheduler/job/1946045
# test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.sirena.=
org.uk/scheduler/job/1947757
# test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.sirena.=
org.uk/scheduler/job/1953765
# test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.sirena.=
org.uk/scheduler/job/1947001
# test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.sirena.=
org.uk/scheduler/job/1946839
# test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.sirena.=
org.uk/scheduler/job/1946680
# test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.sirena.=
org.uk/scheduler/job/1946304
# test job: [7e1fe102c8517a402327c37685357fbe279b3278] https://lava.sirena.=
org.uk/scheduler/job/1982084
# test job: [cc7e1a9b596c9d9dc3324c056cf8162e9fca2765] https://lava.sirena.=
org.uk/scheduler/job/1981487
# test job: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] https://lava.sirena.=
org.uk/scheduler/job/2081200
# test job: [92fd6e84175befa1775e5c0ab682938eca27c0b2] https://lava.sirena.=
org.uk/scheduler/job/2134785
# bad: [92fd6e84175befa1775e5c0ab682938eca27c0b2] Add linux-next specific f=
iles for 20251125
git bisect bad 92fd6e84175befa1775e5c0ab682938eca27c0b2
# test job: [bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0] https://lava.sirena.=
org.uk/scheduler/job/2134899
# bad: [bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0] Merge branch 'master' of =
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect bad bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0
# test job: [614ad23e61af8a745bfdfe50b09870560e5f73f9] https://lava.sirena.=
org.uk/scheduler/job/2135009
# bad: [614ad23e61af8a745bfdfe50b09870560e5f73f9] Merge branch 'fs-next' of=
 linux-next
git bisect bad 614ad23e61af8a745bfdfe50b09870560e5f73f9
# test job: [f9b99d86d8fde5007a7c52347efac13566f8c160] https://lava.sirena.=
org.uk/scheduler/job/2135145
# good: [f9b99d86d8fde5007a7c52347efac13566f8c160] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect good f9b99d86d8fde5007a7c52347efac13566f8c160
# test job: [6dcee998bc550ca1f4d93ada88ddf3ddf88278b5] https://lava.sirena.=
org.uk/scheduler/job/2135213
# bad: [6dcee998bc550ca1f4d93ada88ddf3ddf88278b5] Merge branch 'vfs.all' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
git bisect bad 6dcee998bc550ca1f4d93ada88ddf3ddf88278b5
# test job: [4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c] https://lava.sirena.=
org.uk/scheduler/job/2135251
# bad: [4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c] Merge branch 'vfs-6.19.fd=
_prepare' into vfs.all
git bisect bad 4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c
# test job: [fbcf11d2838ae1df75ef10856e31fbbdd001baa5] https://lava.sirena.=
org.uk/scheduler/job/2135311
# good: [fbcf11d2838ae1df75ef10856e31fbbdd001baa5] Merge branch 'namespace-=
6.19' into vfs.all
git bisect good fbcf11d2838ae1df75ef10856e31fbbdd001baa5
# test job: [5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16] https://lava.sirena.=
org.uk/scheduler/job/2135397
# good: [5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16] Merge branch 'vfs-6.19.d=
irectory.delegations' into vfs.all
git bisect good 5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16
# test job: [d6ef072d09b2341e606aeeaf14c3510dec329c63] https://lava.sirena.=
org.uk/scheduler/job/2135492
# good: [d6ef072d09b2341e606aeeaf14c3510dec329c63] ovl: reflow ovl_create_o=
r_link()
git bisect good d6ef072d09b2341e606aeeaf14c3510dec329c63
# test job: [b27548e6abcc0d771eda10b8ed5aaac5d53ef421] https://lava.sirena.=
org.uk/scheduler/job/2135565
# bad: [b27548e6abcc0d771eda10b8ed5aaac5d53ef421] spufs: convert spufs_cont=
ext_open() to FD_PREPARE()
git bisect bad b27548e6abcc0d771eda10b8ed5aaac5d53ef421
# test job: [6d6454e55b4c84edf4a7914dd0d7033a7b5d0839] https://lava.sirena.=
org.uk/scheduler/job/2135612
# good: [6d6454e55b4c84edf4a7914dd0d7033a7b5d0839] userfaultfd: convert new=
_userfaultfd() to FD_PREPARE()
git bisect good 6d6454e55b4c84edf4a7914dd0d7033a7b5d0839
# test job: [ea66cee99ff4a3e43a9a2356e018473f5dc69872] https://lava.sirena.=
org.uk/scheduler/job/2135809
# bad: [ea66cee99ff4a3e43a9a2356e018473f5dc69872] bpf: convert bpf_token_cr=
eate() to FD_PREPARE()
git bisect bad ea66cee99ff4a3e43a9a2356e018473f5dc69872
# test job: [d67145b51ed0f07a9f68dfe82ec1543c930f2762] https://lava.sirena.=
org.uk/scheduler/job/2136116
# good: [d67145b51ed0f07a9f68dfe82ec1543c930f2762] dma: convert sync_file_i=
octl_merge() to FD_PREPARE()
git bisect good d67145b51ed0f07a9f68dfe82ec1543c930f2762
# test job: [a8dc46d4c3038aaa6f6fee37e7a938bda1967abf] https://lava.sirena.=
org.uk/scheduler/job/2136588
# bad: [a8dc46d4c3038aaa6f6fee37e7a938bda1967abf] ipc: convert do_mq_open()=
 to FD_ADD()
git bisect bad a8dc46d4c3038aaa6f6fee37e7a938bda1967abf
# test job: [fe3e2fc8236bff97cfd5eb8e69350c0b8567bed2] https://lava.sirena.=
org.uk/scheduler/job/2136813
# good: [fe3e2fc8236bff97cfd5eb8e69350c0b8567bed2] exec: convert begin_new_=
exec() to FD_PREPARE()
git bisect good fe3e2fc8236bff97cfd5eb8e69350c0b8567bed2
# first bad commit: [a8dc46d4c3038aaa6f6fee37e7a938bda1967abf] ipc: convert=
 do_mq_open() to FD_ADD()

--3IwkfWdB+QMMglL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkmLg4ACgkQJNaLcl1U
h9CHMQf/bIEqgoxmXNdVeXFlGx26IrnO7Gy3sXIfw43otiQbSglZg0IXGvHlT71c
KPob6MsnSrwmtlCd5B3NFhhBZpqC6GDPpki8Fy12JEDImxI8evYdQgxs6ojsMV5W
4hufC5N6CrG36CJPE4zB0rzzVr9oNk07DJZnyNu7XSwP/ZcsKjISVyH/oG6lPFj7
2q7HFqrMRuJq/vZL8oQLHB5Qm6Pk7SAzzbWZDWTOTvisMtomp2Sdj2YP22z+SyKn
VAfTbYdRrbx7MTxXiGvo0FW+SV9uICCV1OQrEGJdkFr1QqKlmqNTv9ULYUFD014T
qPVDlHQpK8tdzQpBGGynOJxMVArfRg==
=DMWX
-----END PGP SIGNATURE-----

--3IwkfWdB+QMMglL3--

