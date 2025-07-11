Return-Path: <linux-fsdevel+bounces-54595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3BB015A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B415A034F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609623A57F;
	Fri, 11 Jul 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdjRU8Tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB7239E8A;
	Fri, 11 Jul 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221847; cv=none; b=TTimRlmJ1WoewyT68lbO9t6fsFvDyGEC4O8uUHzHZtQGjB820vaDuR4gmU3rX7TQE5AKIimKYGEXgAdPZJ5ehiwBGDRXw5sPdZqDB+TXgWPyW5EgXgMow2e7Mlmc0NxIYQlwHVkUNPSSKzttWyNez4JmvtVGJOcX/nlyDeMnp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221847; c=relaxed/simple;
	bh=N4GUm+i+0VSqJUrv77s4EFx/e7G5SGbpqQ1fN0pEsWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTzr8HTiaGdlODgFmnjYR9DUlSkAffcRWiu23h9lKsk/lwGc0zjyLtl3bHohFmxapvnu9mCoPWioHosHX5aWvpy6lreCc2Wvn54jEDe1LJuoCHLMpsewIOR3+MaCknLCiQWLUFDet8YHIAzEvxPCtV2G4JCBPUKAMrklNLG02i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdjRU8Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1827C4CEED;
	Fri, 11 Jul 2025 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752221847;
	bh=N4GUm+i+0VSqJUrv77s4EFx/e7G5SGbpqQ1fN0pEsWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdjRU8TrxXPrEahfX8DSBIwPJX+EJbuVE+kfEjSwSRIQ5TtdxLd8XrRN4YEOHdTXS
	 V5vQfISv6pZ2ADXYgVO3SSJqRtc7OnH+bv4F/nENzmt54bkCATGjqPl5kAIx693Bhg
	 Q4nUmJ9xC7tEWBfbR0zrVL6hVMdFVBTe1W1NAgpy7sXqgSeW9gh/psgjG2HRttHq2m
	 JyseGA4C79ocQ9PMr1XbLqhaO9siB93sgNZSMqkeZhUOGFbW2uxTuA1wUzC5cgkc8Z
	 ceT7XLZW8Ab3BzWRBnCRhmv3B9IA/KgpmWgknuikL6ikIrF3XhvXpMH0Yv56C8Aez7
	 pKMQO8CFKOLmA==
Date: Fri, 11 Jul 2025 09:17:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <aHDIk6bKzI5kf_be@finisterre.sirena.org.uk>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+vFkTx/f3dMeMiVG"
Content-Disposition: inline
In-Reply-To: <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
X-Cookie: A fool and his money are soon popular.


--+vFkTx/f3dMeMiVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 06:27:52AM +0100, Lorenzo Stoakes wrote:
> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
>=20
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).

I'm seeing failures in the mremap_dontunmap test in -next on Rasperry Pi
4 which bisect down to this patch.  The test logging isn't super helpful
here sadly:

# # --------------------------
# # running ./mremap_dontunmap
# # --------------------------
# # TAP version 13
# # 1..5
# # [FAIL]
# not ok 33 mremap_dontunmap # exit=3D139

Full log at:

   https://lava.sirena.org.uk/scheduler/job/1556942#L3693

Bisect log:

# bad: [b551c4e2a98a177a06148cf16505643cd2108386] Add linux-next specific f=
iles for 20250710
# good: [23c7369d4050e533fe661e5c750181dffe67b4b9] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [c61da55412a08268ea0cdef99dea11f7ade934ee] ASoC: sdw_utils: Add mis=
sed component_name strings for speaker amps
# good: [68e4dadacb7faa393b532b41bbf99a2dbfec3b1b] ASoC: img: Imagination T=
echnologies sound should depend on MIPS
# good: [defe01abfb7f5c5bd53c723b8577d4fcd64faa5a] spi: stm32-ospi: Use of_=
reserved_mem_region_to_resource() for "memory-region"
# good: [86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6] ASoC: Intel: soc-acpi-in=
tel-lnl-match: add rt1320_l12_rt714_l0 support
# good: [5054740e0092aac528c0589251f612b3b41c9e7b] regulator: sy8827n: make=
 enable gpio NONEXCLUSIVE
# good: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] ASoC: soc-dapm: add pref=
ix on soc_dapm_dev_attrs
# good: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] regulator: stm32-vrefbuf=
: Remove redundant pm_runtime_mark_last_busy() calls
# good: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] ASoC: codec: rockchip_sa=
i: Remove including of_gpio.h
# good: [2fca750160f29015ab1109bb478537a4e415f7cd] spi: Remove redundant pm=
_runtime_mark_last_busy() calls
# good: [9f711c9321cffe3e03709176873c277fa911c366] regmap: get rid of redun=
dant debugfs_file_{get,put}()
# good: [bc163baef57002c08b3afe64cdd2f55f55a765eb] ASoC: Use of_reserved_me=
m_region_to_resource() for "memory-region"
# good: [2bd9648d5a8d329ca734ca2c273a80934867471e] ASoC: SOF: Remove redund=
ant pm_runtime_mark_last_busy() calls
# good: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] ASoC: fsl_mqs: rename sy=
stem manager indices for i.MX95
# good: [7105fdd54a14bee49371b39374a61b3c967d74cb] spi: dt-bindings: Conver=
t marvell,orion-spi to DT schema
# good: [913bf8d50cbd144c87e9660b591781179182ff59] spi: spi-qpic-snand: add=
 support for 8 bits ECC strength
# good: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] ASoC: qcom: sc8280xp: Ad=
d support for QCS8275
# good: [0c0ef1d90967717b91cded41b00dbae05d8e521c] ASoC: amd: acp: Enable a=
cp7.2 platform based DMIC support in machine driver
# good: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] spi: offload trigger: ad=
d ADI Util Sigma-Delta SPI driver
# good: [244bc18e5f1875401a4af87d2eae3f9376d9d720] spi: stm32: delete stray=
 tabs in stm32h7_spi_data_idleness()
# good: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] spi: spi-pci1xxxx: enabl=
e concurrent DMA read/write across SPI transfers
# good: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] ASoC: SDCA: Add some ini=
tial IRQ handlers
# good: [c4f2c05ab02952c9a56067aeb700ded95b183570] spi: stm32: fix pointer-=
to-pointer variables usage
# good: [427ceac823e58813b510e585011488f603f0d891] regulator: tps6286x-regu=
lator: Enable REGCACHE_MAPLE
# good: [29ddce17e909779633f856ad1c2f111fbf71c0df] ASoC: codecs: Add calibr=
ation function to aw88399 chip
# good: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] spi: dt-bindings: add nx=
p,lpc3220-spi.yaml
# good: [08bf1663c21a3e815eda28fa242d84c945ca3b94] dmaengine: Add devm_dma_=
request_chan()
# good: [2555691165a0285a4617230fed859f20dcc51608] spi: atmel-quadspi: Use =
`devm_dma_request_chan()`
# good: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] regulator: core: Don't u=
se "proxy" headers
# good: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] ASoC: sdw_utils: generat=
e combined spk components string
# good: [9a944494c299fabf3cc781798eb7c02a0bece364] spi: dt-bindings: stm32:=
 deprecate `st,spi-midi-ns` property
# good: [3e36c822506d924894ff7de549b9377d3114c2d7] spi: spi-pci1xxxx: Add s=
upport for per-instance DMA interrupt vectors
# good: [68fbc70ece40139380380dce74059afa592846b3] ASoC: hisilicon: Standar=
dize ASoC menu
# good: [8f9cf02c8852837923f1cdacfcc92e138513325c] spi: microchip-core-qspi=
: Add regular transfers
# good: [17cc308b183308bf5ada36e164284fff7eb064ba] ASoC: wm8524: enable con=
straints when sysclk is configured.
# good: [59566923d955b69bfb1e1163f07dff437dde8c9c] ASoC: SOF: amd: add alte=
rnate machines for ACP7.0 and ACP7.1 platforms
# good: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] regulator: mtk-dvfsrc: A=
dd support for MediaTek MT8196 DVFSRC
# good: [19cbc930c209d59a2c9828de4c7b767e9f14667e] regulator: pca9450: Supp=
ort PWM mode also for pca9451a
# good: [c4ca928a6db1593802cd945f075a7e21dd0430c1] ASoC: hdac_hdmi: Rate li=
mit logging on connection and disconnection
# good: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] ASoC: codecs: wcd939x: A=
dd defines for major/minor version decoding
# good: [3421d46440ebe0865bec71dbd2330b4e17a425ab] HID: core: Add bus defin=
e for SoundWire bus
# good: [a1d203d390e04798ccc1c3c06019cd4411885d6d] ASoC: SOF: ipc4-pcm: Ena=
ble delay reporting for ChainDMA streams
# good: [bb48117b79ebc39485f7306d09dc602981fe540f] ASoC: Intel: sof_sdw: Im=
plement add_dai_link to filter HDMI PCMs
# good: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] ASoC: SOF: ipc4-pcm: Har=
monize sof_ipc4_set_pipeline_state() dbg print
# good: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] ASoC: SOF: ipc4/Intel: A=
dd support for library restore firmware functionality
# good: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] Documentation: PM: *_aut=
osuspend() functions update last busy time
# good: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] spi: falcon: mark falcon=
_sflash_xfer() as static
# good: [7f8924e8785b68c998bc1906e049bf5595865e60] ASoC: dt-bindings: cirru=
s,cs42xx8: add 'port' property
# good: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] regulator: rpi-panel-v2:=
 Add shutdown hook
# good: [d9f38d9824bfb1b046d2e720349d2f45959ab184] ASoC: tegra: AHUB: Remov=
e unneeded semicolon
# good: [dce4bc30f42d313b4dc5832316196411b7f07ad0] spi: spi-fsl-dspi: Rever=
t unintended dependency change in config SPI_FSL_DSPI
# good: [47972c1c3315672352f25c68f91dd88543541947] ASoC: Intel: Replace dep=
recated strcpy() with strscpy()
# good: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] ASoC: hdmi-codec: use SN=
D_JACK_AVOUT as jack status
# good: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] ASoC: mediatek: mt8183-a=
fe-pcm: use local `dev` pointer in driver callbacks
# good: [8a5a5cecb79058b608e5562d8998123a3adb313c] ASoC: tas2781: Move the =
"include linux/debugfs.h" into tas2781.h
# good: [a4eb71ff98c4792f441f108910bd829da7a04092] regulator: rpi-panel-v2:=
 Fix missing OF dependency
# good: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] spi: spi-mt65xx: Add sup=
port for MT6991 Dimensity 9400 SPI IPM
# good: [7e10d7242ea8a5947878880b912ffa5806520705] ASoC: ops: dynamically a=
llocate struct snd_ctl_elem_value
# good: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] regulator: rpi-panel-v2:=
 Add missing GPIOLIB dependency
# good: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] ASoC: codecs: Add suppor=
t for Richtek RTQ9124
# good: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] regulator: rpi-panel-v2:=
 Add regulator for 7" Raspberry Pi 720x1280
# good: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] ASoC: renesas: msiof: Co=
nvert to <linux/spi/sh_msiof.h>
# good: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] ASOC: rockchip: Use help=
er function devm_clk_get_enabled()
# good: [c459262159f39e6e6336797feb975799344b749b] spi: spi-pci1xxxx: Add s=
upport for 25MHz Clock frequency in C0
# good: [548d770c330cd1027549947a6ea899c56b5bc4e4] regulator: pca9450: Add =
support for mode operations
# good: [267be32b0a7b70cc777f8a46f0904c92c0521d89] ASoC: remove component->=
id
# good: [f6f914893d478b7ba08e5c375de1ced16deb5e92] ASoC: dt-bindings: tas57=
xx: add tas5753 compatibility
# good: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] ASoC: imx-card: Use help=
er function for_each_child_of_node_scoped()
# good: [9a30e332c36c52e92e5316b4a012d45284dedeb5] spi: spi-fsl-dspi: Enabl=
e support for S32G platforms
# good: [c95e925daa434ee1a40a86aec6476ce588e4bd77] ASoC: Intel: avs: Add rt=
5640 machine board
# good: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] regmap: kunit: Constify =
regmap_range_cfg array
# good: [e6e8897995a9e6028563ce36c27877e5478c8571] ASoC: qcom: sm8250: Add =
Fairphone 5 soundcard compatible
# good: [ece5d881004f041c2e1493436409dbcbea3ad5f8] ASoC: codecs: wcd939x: D=
rop unused 'struct wcd939x_priv' fields
# good: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] ASoC: codecs: wcd939x: A=
dd VDD_PX supply
# good: [ac209bde018fd320b79976657a44c23113181af6] ASoC: tas2781: Drop the =
unnecessary symbol imply
# good: [59d1fc7b3e1ae9d46799da0e71dafc7d71a154a0] fbdev: pm3fb: fix potent=
ial divide by zero
git bisect start 'b551c4e2a98a177a06148cf16505643cd2108386' '23c7369d4050e5=
33fe661e5c750181dffe67b4b9' 'c61da55412a08268ea0cdef99dea11f7ade934ee' '68e=
4dadacb7faa393b532b41bbf99a2dbfec3b1b' 'defe01abfb7f5c5bd53c723b8577d4fcd64=
faa5a' '86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6' '5054740e0092aac528c05892=
51f612b3b41c9e7b' '08dc0f5cc26a203e8008c38d9b436c079e7dbb45' 'c61e94e5e4e6b=
c50064119e6a779564d1d2ac0e7' '571defe0dff3f1e4180bd0db79283d3d5bf74a71' '2f=
ca750160f29015ab1109bb478537a4e415f7cd' '9f711c9321cffe3e03709176873c277fa9=
11c366' 'bc163baef57002c08b3afe64cdd2f55f55a765eb' '2bd9648d5a8d329ca734ca2=
c273a80934867471e' 'baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd' '7105fdd54a14=
bee49371b39374a61b3c967d74cb' '913bf8d50cbd144c87e9660b591781179182ff59' '3=
4d340d48e595f8dfd4e72fe4100d2579dbe4a1a' '0c0ef1d90967717b91cded41b00dbae05=
d8e521c' '3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff' '244bc18e5f1875401a4af8=
7d2eae3f9376d9d720' '7e1c28fbf235791cb5046fafdac5bc16fe8e788d' 'b9ab3b61824=
190b1c6b2c59e7ba4de591f24eb92' 'c4f2c05ab02952c9a56067aeb700ded95b183570' '=
427ceac823e58813b510e585011488f603f0d891' '29ddce17e909779633f856ad1c2f111f=
bf71c0df' 'ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea' '08bf1663c21a3e815eda2=
8fa242d84c945ca3b94' '2555691165a0285a4617230fed859f20dcc51608' 'ce57bc9771=
411d6d27f2ca7b40396cbd7d684ba9' '0f60ecffbfe35e12eb56c99640ba2360244b5bb3' =
'9a944494c299fabf3cc781798eb7c02a0bece364' '3e36c822506d924894ff7de549b9377=
d3114c2d7' '68fbc70ece40139380380dce74059afa592846b3' '8f9cf02c8852837923f1=
cdacfcc92e138513325c' '17cc308b183308bf5ada36e164284fff7eb064ba' '59566923d=
955b69bfb1e1163f07dff437dde8c9c' '024f39fff6d222cedde361f7fe34d9ba4e6afb92'=
 '19cbc930c209d59a2c9828de4c7b767e9f14667e' 'c4ca928a6db1593802cd945f075a7e=
21dd0430c1' 'a48352921f0b15b1f7eff83f5b5613d6ae2350d3' '3421d46440ebe0865be=
c71dbd2330b4e17a425ab' 'a1d203d390e04798ccc1c3c06019cd4411885d6d' 'bb48117b=
79ebc39485f7306d09dc602981fe540f' '2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34=
' 'ace9b3daf2b4778358573d3698e34cb1c0fa7e14' 'cd4da713f99651e99fbce8ed6b6ec=
8f686c029a8' '5fc2c383125c2b4b6037e02ad8796b776b25e6d0' '7f8924e8785b68c998=
bc1906e049bf5595865e60' '3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115' 'd9f38d9=
824bfb1b046d2e720349d2f45959ab184' 'dce4bc30f42d313b4dc5832316196411b7f07ad=
0' '47972c1c3315672352f25c68f91dd88543541947' '5eb8a0d7733d4cd32a776acf1d1a=
a1c7c01c8a14' 'bb8d8ba4715cb8f997d63d90ba935f6073595df5' '8a5a5cecb79058b60=
8e5562d8998123a3adb313c' 'a4eb71ff98c4792f441f108910bd829da7a04092' '6cafcc=
53eb5fffd9b9bdfde700bb9bad21e98ed3' '7e10d7242ea8a5947878880b912ffa58065207=
05' 'd6fa0ca959db8efd4462d7beef4bdc5568640fd0' '1f5cdb6ab45e1c06ae0953609ac=
bb52f8946b3e8' 'd49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4' '6ba68e5aa9d5d15c=
8877a655db279fcfc0b38b04' '03b778d1994827ea5cc971dbdfbb457bbb7bfa5d' 'c4592=
62159f39e6e6336797feb975799344b749b' '548d770c330cd1027549947a6ea899c56b5bc=
4e4' '267be32b0a7b70cc777f8a46f0904c92c0521d89' 'f6f914893d478b7ba08e5c375d=
e1ced16deb5e92' '111a2c8ab462d77d1519b71b46f13ae1b46920b4' '9a30e332c36c52e=
92e5316b4a012d45284dedeb5' 'c95e925daa434ee1a40a86aec6476ce588e4bd77' 'c8c4=
694ede7ed42d8d4db0e8927dea9839a3e248' 'e6e8897995a9e6028563ce36c27877e5478c=
8571' 'ece5d881004f041c2e1493436409dbcbea3ad5f8' 'b9ecde0bcf6a99a3ff08496d4=
ba90a385ebbfd68' 'ac209bde018fd320b79976657a44c23113181af6' '59d1fc7b3e1ae9=
d46799da0e71dafc7d71a154a0'
# test job: [c61da55412a08268ea0cdef99dea11f7ade934ee] https://lava.sirena.=
org.uk/scheduler/job/1554477
# test job: [68e4dadacb7faa393b532b41bbf99a2dbfec3b1b] https://lava.sirena.=
org.uk/scheduler/job/1553557
# test job: [defe01abfb7f5c5bd53c723b8577d4fcd64faa5a] https://lava.sirena.=
org.uk/scheduler/job/1553629
# test job: [86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6] https://lava.sirena.=
org.uk/scheduler/job/1547910
# test job: [5054740e0092aac528c0589251f612b3b41c9e7b] https://lava.sirena.=
org.uk/scheduler/job/1546901
# test job: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] https://lava.sirena.=
org.uk/scheduler/job/1546283
# test job: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] https://lava.sirena.=
org.uk/scheduler/job/1538599
# test job: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] https://lava.sirena.=
org.uk/scheduler/job/1539773
# test job: [2fca750160f29015ab1109bb478537a4e415f7cd] https://lava.sirena.=
org.uk/scheduler/job/1540311
# test job: [9f711c9321cffe3e03709176873c277fa911c366] https://lava.sirena.=
org.uk/scheduler/job/1538686
# test job: [bc163baef57002c08b3afe64cdd2f55f55a765eb] https://lava.sirena.=
org.uk/scheduler/job/1538770
# test job: [2bd9648d5a8d329ca734ca2c273a80934867471e] https://lava.sirena.=
org.uk/scheduler/job/1539579
# test job: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] https://lava.sirena.=
org.uk/scheduler/job/1533839
# test job: [7105fdd54a14bee49371b39374a61b3c967d74cb] https://lava.sirena.=
org.uk/scheduler/job/1533549
# test job: [913bf8d50cbd144c87e9660b591781179182ff59] https://lava.sirena.=
org.uk/scheduler/job/1531275
# test job: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] https://lava.sirena.=
org.uk/scheduler/job/1530304
# test job: [0c0ef1d90967717b91cded41b00dbae05d8e521c] https://lava.sirena.=
org.uk/scheduler/job/1530359
# test job: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] https://lava.sirena.=
org.uk/scheduler/job/1528973
# test job: [244bc18e5f1875401a4af87d2eae3f9376d9d720] https://lava.sirena.=
org.uk/scheduler/job/1528302
# test job: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] https://lava.sirena.=
org.uk/scheduler/job/1525649
# test job: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] https://lava.sirena.=
org.uk/scheduler/job/1526361
# test job: [c4f2c05ab02952c9a56067aeb700ded95b183570] https://lava.sirena.=
org.uk/scheduler/job/1526591
# test job: [427ceac823e58813b510e585011488f603f0d891] https://lava.sirena.=
org.uk/scheduler/job/1525654
# test job: [29ddce17e909779633f856ad1c2f111fbf71c0df] https://lava.sirena.=
org.uk/scheduler/job/1523992
# test job: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] https://lava.sirena.=
org.uk/scheduler/job/1517626
# test job: [08bf1663c21a3e815eda28fa242d84c945ca3b94] https://lava.sirena.=
org.uk/scheduler/job/1517665
# test job: [2555691165a0285a4617230fed859f20dcc51608] https://lava.sirena.=
org.uk/scheduler/job/1515754
# test job: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] https://lava.sirena.=
org.uk/scheduler/job/1515782
# test job: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] https://lava.sirena.=
org.uk/scheduler/job/1511594
# test job: [9a944494c299fabf3cc781798eb7c02a0bece364] https://lava.sirena.=
org.uk/scheduler/job/1507934
# test job: [3e36c822506d924894ff7de549b9377d3114c2d7] https://lava.sirena.=
org.uk/scheduler/job/1506338
# test job: [68fbc70ece40139380380dce74059afa592846b3] https://lava.sirena.=
org.uk/scheduler/job/1504159
# test job: [8f9cf02c8852837923f1cdacfcc92e138513325c] https://lava.sirena.=
org.uk/scheduler/job/1502880
# test job: [17cc308b183308bf5ada36e164284fff7eb064ba] https://lava.sirena.=
org.uk/scheduler/job/1501547
# test job: [59566923d955b69bfb1e1163f07dff437dde8c9c] https://lava.sirena.=
org.uk/scheduler/job/1499646
# test job: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] https://lava.sirena.=
org.uk/scheduler/job/1499695
# test job: [19cbc930c209d59a2c9828de4c7b767e9f14667e] https://lava.sirena.=
org.uk/scheduler/job/1497287
# test job: [c4ca928a6db1593802cd945f075a7e21dd0430c1] https://lava.sirena.=
org.uk/scheduler/job/1496260
# test job: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] https://lava.sirena.=
org.uk/scheduler/job/1497370
# test job: [3421d46440ebe0865bec71dbd2330b4e17a425ab] https://lava.sirena.=
org.uk/scheduler/job/1493080
# test job: [a1d203d390e04798ccc1c3c06019cd4411885d6d] https://lava.sirena.=
org.uk/scheduler/job/1491512
# test job: [bb48117b79ebc39485f7306d09dc602981fe540f] https://lava.sirena.=
org.uk/scheduler/job/1489355
# test job: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] https://lava.sirena.=
org.uk/scheduler/job/1489208
# test job: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] https://lava.sirena.=
org.uk/scheduler/job/1489287
# test job: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] https://lava.sirena.=
org.uk/scheduler/job/1538824
# test job: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] https://lava.sirena.=
org.uk/scheduler/job/1486895
# test job: [7f8924e8785b68c998bc1906e049bf5595865e60] https://lava.sirena.=
org.uk/scheduler/job/1486909
# test job: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] https://lava.sirena.=
org.uk/scheduler/job/1481719
# test job: [d9f38d9824bfb1b046d2e720349d2f45959ab184] https://lava.sirena.=
org.uk/scheduler/job/1481618
# test job: [dce4bc30f42d313b4dc5832316196411b7f07ad0] https://lava.sirena.=
org.uk/scheduler/job/1479448
# test job: [47972c1c3315672352f25c68f91dd88543541947] https://lava.sirena.=
org.uk/scheduler/job/1479573
# test job: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] https://lava.sirena.=
org.uk/scheduler/job/1474690
# test job: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] https://lava.sirena.=
org.uk/scheduler/job/1472408
# test job: [8a5a5cecb79058b608e5562d8998123a3adb313c] https://lava.sirena.=
org.uk/scheduler/job/1472426
# test job: [a4eb71ff98c4792f441f108910bd829da7a04092] https://lava.sirena.=
org.uk/scheduler/job/1468996
# test job: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] https://lava.sirena.=
org.uk/scheduler/job/1468939
# test job: [7e10d7242ea8a5947878880b912ffa5806520705] https://lava.sirena.=
org.uk/scheduler/job/1466044
# test job: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] https://lava.sirena.=
org.uk/scheduler/job/1464680
# test job: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] https://lava.sirena.=
org.uk/scheduler/job/1462968
# test job: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] https://lava.sirena.=
org.uk/scheduler/job/1463040
# test job: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] https://lava.sirena.=
org.uk/scheduler/job/1463329
# test job: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] https://lava.sirena.=
org.uk/scheduler/job/1461889
# test job: [c459262159f39e6e6336797feb975799344b749b] https://lava.sirena.=
org.uk/scheduler/job/1460981
# test job: [548d770c330cd1027549947a6ea899c56b5bc4e4] https://lava.sirena.=
org.uk/scheduler/job/1460090
# test job: [267be32b0a7b70cc777f8a46f0904c92c0521d89] https://lava.sirena.=
org.uk/scheduler/job/1460420
# test job: [f6f914893d478b7ba08e5c375de1ced16deb5e92] https://lava.sirena.=
org.uk/scheduler/job/1461475
# test job: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] https://lava.sirena.=
org.uk/scheduler/job/1460866
# test job: [9a30e332c36c52e92e5316b4a012d45284dedeb5] https://lava.sirena.=
org.uk/scheduler/job/1460552
# test job: [c95e925daa434ee1a40a86aec6476ce588e4bd77] https://lava.sirena.=
org.uk/scheduler/job/1460133
# test job: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] https://lava.sirena.=
org.uk/scheduler/job/1461293
# test job: [e6e8897995a9e6028563ce36c27877e5478c8571] https://lava.sirena.=
org.uk/scheduler/job/1461776
# test job: [ece5d881004f041c2e1493436409dbcbea3ad5f8] https://lava.sirena.=
org.uk/scheduler/job/1461679
# test job: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] https://lava.sirena.=
org.uk/scheduler/job/1461079
# test job: [ac209bde018fd320b79976657a44c23113181af6] https://lava.sirena.=
org.uk/scheduler/job/1461915
# test job: [59d1fc7b3e1ae9d46799da0e71dafc7d71a154a0] https://lava.sirena.=
org.uk/scheduler/job/1486270
# test job: [b551c4e2a98a177a06148cf16505643cd2108386] https://lava.sirena.=
org.uk/scheduler/job/1556942
# bad: [b551c4e2a98a177a06148cf16505643cd2108386] Add linux-next specific f=
iles for 20250710
git bisect bad b551c4e2a98a177a06148cf16505643cd2108386
# test job: [f3de7f26f8f9605ff28de30c0aede05f8d4e200e] https://lava.sirena.=
org.uk/scheduler/job/1556998
# bad: [f3de7f26f8f9605ff28de30c0aede05f8d4e200e] Merge branch 'main' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad f3de7f26f8f9605ff28de30c0aede05f8d4e200e
# test job: [9dad5d75b0f2a73d55ed8086e9358043d2e0c716] https://lava.sirena.=
org.uk/scheduler/job/1557216
# bad: [9dad5d75b0f2a73d55ed8086e9358043d2e0c716] Merge branch 'fs-next' of=
 linux-next
git bisect bad 9dad5d75b0f2a73d55ed8086e9358043d2e0c716
# test job: [454cf3d6f23d6190f3ed7041df67b1b9f341401c] https://lava.sirena.=
org.uk/scheduler/job/1557308
# bad: [454cf3d6f23d6190f3ed7041df67b1b9f341401c] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
git bisect bad 454cf3d6f23d6190f3ed7041df67b1b9f341401c
# test job: [cf9c77f6aac29c615ae95863ae8b166ef545a706] https://lava.sirena.=
org.uk/scheduler/job/1557353
# bad: [cf9c77f6aac29c615ae95863ae8b166ef545a706] Merge branch 'for-next/pe=
rf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
git bisect bad cf9c77f6aac29c615ae95863ae8b166ef545a706
# test job: [96af8062e56b3b6e498e5e428c95c2851e0928da] https://lava.sirena.=
org.uk/scheduler/job/1557498
# good: [96af8062e56b3b6e498e5e428c95c2851e0928da] mm/mremap: refactor init=
ial parameter sanity checks
git bisect good 96af8062e56b3b6e498e5e428c95c2851e0928da
# test job: [585189332afe02c99e66c6a0d328fe05e456ff6a] https://lava.sirena.=
org.uk/scheduler/job/1557542
# good: [585189332afe02c99e66c6a0d328fe05e456ff6a] perf vendor events: Upda=
te TigerLake events
git bisect good 585189332afe02c99e66c6a0d328fe05e456ff6a
# test job: [1fee8fec454108627040ef10e82ae069d4fd6011] https://lava.sirena.=
org.uk/scheduler/job/1557714
# bad: [1fee8fec454108627040ef10e82ae069d4fd6011] Merge branch 'perf-tools-=
next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
=2Egit
git bisect bad 1fee8fec454108627040ef10e82ae069d4fd6011
# test job: [0f6de4b4991f0928010f1adb3510fe4f28a39151] https://lava.sirena.=
org.uk/scheduler/job/1557844
# good: [0f6de4b4991f0928010f1adb3510fe4f28a39151] ocfs2: embed actual valu=
es into ocfs2_sysfile_lock_key names
git bisect good 0f6de4b4991f0928010f1adb3510fe4f28a39151
# test job: [c72e3e275d53bb3346882830aeff0548f2e49939] https://lava.sirena.=
org.uk/scheduler/job/1557926
# good: [c72e3e275d53bb3346882830aeff0548f2e49939] squashfs: fix incorrect =
argument to sizeof in kmalloc_array call
git bisect good c72e3e275d53bb3346882830aeff0548f2e49939
# test job: [eecc2c71dba4c9578d8cc3a1d45b1b2d8f38e72d] https://lava.sirena.=
org.uk/scheduler/job/1557958
# bad: [eecc2c71dba4c9578d8cc3a1d45b1b2d8f38e72d] Merge branch 'mm-unstable=
' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad eecc2c71dba4c9578d8cc3a1d45b1b2d8f38e72d
# test job: [1ddb6c7254bd854323be891703b1fa5971f9dc23] https://lava.sirena.=
org.uk/scheduler/job/1558086
# good: [1ddb6c7254bd854323be891703b1fa5971f9dc23] mm/mremap: check remap c=
onditions earlier
git bisect good 1ddb6c7254bd854323be891703b1fa5971f9dc23
# test job: [4faaafd5b36a76b214af76679edb664ae12ed1e9] https://lava.sirena.=
org.uk/scheduler/job/1558195
# good: [4faaafd5b36a76b214af76679edb664ae12ed1e9] mm/mremap: clean up mloc=
k populate behaviour
git bisect good 4faaafd5b36a76b214af76679edb664ae12ed1e9
# test job: [db63de7a28bf61149a11217e527944396cfaf30a] https://lava.sirena.=
org.uk/scheduler/job/1558295
# bad: [db63de7a28bf61149a11217e527944396cfaf30a] tools/testing/selftests: =
extend mremap_test to test multi-VMA mremap
git bisect bad db63de7a28bf61149a11217e527944396cfaf30a
# test job: [b4bfab2332244ef12c6a9fb1165d67f0e4747e1f] https://lava.sirena.=
org.uk/scheduler/job/1558332
# bad: [b4bfab2332244ef12c6a9fb1165d67f0e4747e1f] mm/mremap: permit mremap(=
) move of multiple VMAs
git bisect bad b4bfab2332244ef12c6a9fb1165d67f0e4747e1f
# first bad commit: [b4bfab2332244ef12c6a9fb1165d67f0e4747e1f] mm/mremap: p=
ermit mremap() move of multiple VMAs

--+vFkTx/f3dMeMiVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhwyJMACgkQJNaLcl1U
h9AxVwf9HnnUp/fPhz43VmTe4iPcfBK+CVhRqCueyHdaDYpAfOQ902iDLW7KvJ9z
/TQU4rXF1TMq8kdyFTeiMks0VHuGWQEfyxHGGZO4PEKoMnfbI3tHoV4O/cev9107
e+oQnB2OfC5MGd5XbKo1MNMs2QkMCeUOMXCZmFfUzMARy7cLm2Ejjy1ImLuADlAG
LDBdPkKnYRSOYaugrQOTSNh1l0v7mnJ78PfrYRxzfNSCB3wMHHvY5PuMzWlZxGiA
TBIVxfmVTpkTXRiYXuN7aG+KWkSyynCz4Dfn00wyfHmkg7nirPq4PwCepkdCnlWW
rmCw7GvNThiAFewULbs08dL1G+9d1w==
=S6zs
-----END PGP SIGNATURE-----

--+vFkTx/f3dMeMiVG--

