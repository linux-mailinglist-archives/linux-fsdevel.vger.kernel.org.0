Return-Path: <linux-fsdevel+bounces-69890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963FC8A0E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893EB3B056E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD19329368;
	Wed, 26 Nov 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd0HbYEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCE2F6578
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164138; cv=none; b=Lw/uY6uPqWvqZVm2ELmc72TY5houwHADudr1W3IL4f1wPS3jwrycz/vM8kE7TOwYazgw4whLvGZJ3QGmXy98HuH5D5wQoygUvjBLA3Jy8XFxq8mqH+bUZWKt2QzpFiFj/7Rotc5CjXA9knpwHMLe2oIBP1fGzq3lMdi3Fuz1ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164138; c=relaxed/simple;
	bh=4XbmUxxoh5StxvoPn3IRBKQkc7A0OePVFWyN1TcGlm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9b7DX1AHSTlukD8EjkYTMrm58J2M3vjnRS+K3mooZ5OhjeFo/rBzChXLCLIXR4nqvYrZjZ5QOzGBz6J8lpwEJ6W4NbCWspiKXp35MZfw+9Cfd/yIOzuzMBKtBGR1nitPcO0Z0rFBr6lCnxyZxWF/3fZ6umOhua+Lu6Kg3hX5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd0HbYEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744A4C113D0;
	Wed, 26 Nov 2025 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764164138;
	bh=4XbmUxxoh5StxvoPn3IRBKQkc7A0OePVFWyN1TcGlm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd0HbYEINntbt2BVnUYSq/efdMMvooza/pbMNIUsnns0tmP9wwxvuRFHbE5GNyZYR
	 hiVz+kwjdGlCJ2xX6RxpX/E8J+FCtn3drUvjyX8A5g5RdV3FSQXta+WytWiCf9zOHR
	 w/r/MIvfwSwz66aK/mgJSMtA/vqMPC+0tSlrDZNHAu64ID2sUHQJvq6XNQ15MYy8Dz
	 V4mgk8pbKaC3u1dDhJGFUXN8KxFGPu1YCx+Gy4YGZcthcd9Sf/tt/SDE8S62ZgPRxI
	 J5/EmiLPW80/Ht/Zt9WNlmkGwWwutg8aFPyX85mWJS04qF3M7G0KgR8gO2J8hN4Mrp
	 IlfSHe4ahv6ng==
Date: Wed, 26 Nov 2025 14:35:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 42/47] tty: convert ptm_open_peer() to FD_PREPARE()
Message-ID: <20251126-simulation-vertiefen-ad4be4d47f0d@brauner>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-42-b6efa1706cfd@kernel.org>
 <37ac7af5-584f-4768-a462-4d1071c43eaf@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <37ac7af5-584f-4768-a462-4d1071c43eaf@sirena.org.uk>

On Tue, Nov 25, 2025 at 10:39:37PM +0000, Mark Brown wrote:
> On Sun, Nov 23, 2025 at 05:34:00PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>=20
> > -	fd_install(fd, filp);
> > +	fd =3D FD_ADD(flags, dentry_open(&path, flags, current_cred()));
> > +	if (fd < 0)
> > +		mntput(path.mnt);
>=20
> I'm seeing a regression in -next in the filesystems devpts_pts kselftest
> which bisects to this patch:
>=20
> # selftests: filesystems: devpts_pts
> # Failed to perform TIOCGPTPEER ioctl
> # Failed to unmount "/dev/pts": Device or resource busy

Yeah, this is a dumb bug. I fixed that.

Adding:

commit 138027e74e9f602e3bb91112dd38840c7a5007e4
Author:     Christian Brauner <brauner@kernel.org>

    devpts: preserve original file opening pattern

    LTP seems to have assertions about what errnos are surfaced in what
    order. I think that's often misguided but we can accomodate this here
    and preserve the original order.

    This also makes sure to unconditionally release the reference on the
    mount that we've taken after we opened the file.

    Fixes: https://lore.kernel.org/37ac7af5-584f-4768-a462-4d1071c43eaf@sir=
ena.org.uk
    Fixes: b945a44e919a ("tty: convert ptm_open_peer() to FD_ADD()")
    Reported-by: Mark Brown <broonie@kernel.org>
    Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index e6249c2b5672..41c1d909525c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -589,6 +589,23 @@ static inline void legacy_pty_init(void) { }
 #ifdef CONFIG_UNIX98_PTYS
 static struct cdev ptmx_cdev;

+static struct file *ptm_open_peer_file(struct file *master,
+                                      struct tty_struct *tty, int flags)
+{
+       struct path path;
+       struct file *file;
+
+       /* Compute the slave's path */
+       path.mnt =3D devpts_mntget(master, tty->driver_data);
+       if (IS_ERR(path.mnt))
+               return ERR_CAST(path.mnt);
+       path.dentry =3D tty->link->driver_data;
+
+       file =3D dentry_open(&path, flags, current_cred());
+       mntput(path.mnt);
+       return file;
+}
+
 /**
  *     ptm_open_peer - open the peer of a pty
  *     @master: the open struct file of the ptmx device node
@@ -601,22 +618,10 @@ static struct cdev ptmx_cdev;
  */
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
-       int fd;
-       struct path path;
-
        if (tty->driver !=3D ptm_driver)
                return -EIO;

-       /* Compute the slave's path */
-       path.mnt =3D devpts_mntget(master, tty->driver_data);
-       if (IS_ERR(path.mnt))
-               return PTR_ERR(path.mnt);
-       path.dentry =3D tty->link->driver_data;
-
-       fd =3D FD_ADD(flags, dentry_open(&path, flags, current_cred()));
-       if (fd < 0)
-               mntput(path.mnt);
-       return fd;
+       return FD_ADD(flags, ptm_open_peer_file(master, tty, flags));
 }

 static int pty_unix98_ioctl(struct tty_struct *tty,

> not ok 1 selftests: filesystems: devpts_pts # exit=3D1
>=20
> Full log:
>=20
>     https://lava.sirena.org.uk/scheduler/job/2134811#L6956
>=20
> This one seems more clearly like a real problem than the other issue in
> the same series that I just reported, but I've only given this the most
> superficial look so possibly it's a test issue.  As with that one the
> subject says FD_PREPARE() but the patch actually converts to FD_ADD().
>=20
> bisect log:
>=20
> # bad: [92fd6e84175befa1775e5c0ab682938eca27c0b2] Add linux-next specific=
 files for 20251125
> # good: [07e9a68478302d35f3372ac8c9994d679a9cfdca] Merge branch 'for-linu=
x-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> # good: [cb99656b7c4185953c9d272bbdab63c8aa651e6e] spi: Fix potential uni=
nitialized variable in probe()
> # good: [df919994d323c7c86e32fa2745730136d58ada12] ASoC: Intel: avs: Repl=
ace snprintf() with scnprintf()
> # good: [670500b41e543c5cb09eb9f7f0e4e26c5b5fdf7e] regulator: pca9450: Fi=
x error code in probe()
> # good: [3af1815a2f9caebfc666af3912e24d030a5368d5] ASoC: SDCA: Add basic =
SDCA function driver
> # good: [3efee7362dbf896072af1c1aaeaf9fd6e235c591] ASoC: SDCA: Add stubs =
for FDL helper functions
> # good: [f1c668269ded16bea32a11d03f4584caa0c018c9] regulator: qcomm-labib=
b: replace use of system_wq with system_dfl_wq
> # good: [43a3adb6dd39d98bf84e04569e7604be5e5c0d79] spi: spidev: add compa=
tible for arduino spi mcu interface
> # good: [33822d795ab93067d9a65f42003c0d01c65d4a9d] ASoC: cs35l56: Use SND=
_SOC_BYTES_E_ACC() for CAL_DATA_RB control
> # good: [d5089fffe1db04a802b028c2ef4875be1ed452a3] ASoC: tas2781: Add tas=
2568/2574/5806m/5806md/5830 support
> # good: [12d821bd13d42e6de3ecb1c13918b1f06a3ee213] regulator: Add FP9931/=
JD9930 driver
> # good: [3045e29d248bde2a68da425498a656093ee0df69] firmware: cs_dsp: Appe=
nd \n to debugfs string during read
> # good: [bdf96e9135a0cf53a853a19c30fa11131a744062] ASoC: codecs: lpass-rx=
-macro: fix mute_stream affecting all paths
> # good: [e2c48498a93404743e0565dcac29450fec02e6a3] ASoC: soc-core: Pre-ch=
eck zero CPU/codec DAIs, handle early rtd->dais alloc failure
> # good: [7a0a87712120329c034b0aae88bdaa05bd046f10] ASoC: wsa883x: drop GP=
IOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
> # good: [b871d9adffe5a64a1fd9edcb1aebbcc995b17901] regulator: make the su=
bsystem aware of shared GPIOs
> # good: [d9813cd23d5a7b254cc1b1c1ea042634d8da62e6] spi: sophgo: Fix incor=
rect use of bus width value macros
> # good: [e45979641a9a9dbb48fc77c5b36a5091a92e7227] ASoC: SOF: sof-client-=
probes: Replace snprintf() with scnprintf()
> # good: [d218ea171430e49412804efb794942dd121a8032] ASoC: mediatek: mt8189=
: add machine driver with nau8825
> # good: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] regulator: renesas-usb=
-vbus-regulator: Remove unused headers
> # good: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] MAINTAINERS: adjust fi=
le entry in RISC-V MICROCHIP SUPPORT
> # good: [96498e804cb6629e02747336a0a33e4955449732] spi: davinci: remove p=
latform data header
> # good: [9e510e677090bb794b46348b10e1c8038286e00a] spi: aspeed: Add suppo=
rt for the AST2700 SPI controller
> # good: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] ASoC: ux500: mop500_ab=
8500: convert to snd_soc_dapm_xxx()
> # good: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] ASoC: Intel: avs: Hono=
r NHLT override when setting up a path
> # good: [118eb2cb97b8fc0d515bb0449495959247db58f0] spi: bcm63xx: drop wro=
ng casts in probe()
> # good: [f7ae6d4ec6520a901787cbab273983e96d8516da] PCI/TSM: Add 'dsm' and=
 'bound' attributes for dependent functions
> # good: [079115370d00c78ef69b31dd15def90adf2aa579] PCI/IDE: Initialize an=
 ID for all IDE streams
> # good: [059f545832be85d29ac9ccc416a16f647aa78485] spi: add support for m=
icrochip "soft" spi controller
> # good: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] MAINTAINERS: refer to =
trivial-codec.yaml in relevant sections
> # good: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] spi: spi-cadence: supp=
orts transmission with bits_per_word of 16 and 32
> # good: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] ASoC: codecs: lpass-rx=
-macro: add SM6115 compatible
> # good: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] firmware: cs_dsp: fix =
kernel-doc warnings in a header file
> # good: [e65b871c9b5af9265aefc5b8cd34993586d93aab] ASoC: codecs: pm4125: =
Remove irq_chip on component unbind
> # good: [123cd174a3782307787268adf45f22de4d290128] ASoC: Intel: atom: Rep=
lace strcpy() with strscpy()
> # good: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] spi: dt-bindings: nuvo=
ton,npcm-pspi: Convert to DT schema
> # good: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] ASoC: Intel: boards: f=
ix HDMI playback lookup when HDMI-In capture used
> # good: [32172cf3cb543a04c41a1677c97a38e60cad05b6] ASoC: cs35l56: Allow r=
estoring factory calibration through ALSA control
> # good: [873bc94689d832878befbcadc10b6ad5bb4e0027] ASoC: Intel: sof_sdw: =
add codec speaker support for the SKU
> # good: [b3a5302484033331af37569f7277d00131694b57] ASoC: Intel: sof_rt568=
2: Add quirk override support
> # good: [772ada50282b0c80343c8989147db816961f571d] ASoC: cs35l56: Alter e=
rror codes for calibration routine
> # good: [fb1ebb10468da414d57153ddebaab29c38ef1a78] regulator: core: disab=
le supply if enabling main regulator fails
> # good: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] regmap: sdw-mbq: Reord=
er regmap_mbq_context struct for better packing
> # good: [6951be397ca8b8b167c9f99b5a11c541148c38cb] ASoC: codecs: pm4125: =
remove duplicate code
> # good: [4e92abd0a11b91af3742197a9ca962c3c00d0948] spi: imx: add i.MX51 E=
CSPI target mode support
> # good: [2089f086303b773e181567fd8d5df3038bd85937] regulator: mt6363: Rem=
ove unneeded semicolon
> # good: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] spi: fsl-qspi: support=
 the SpacemiT K1 SoC
> # good: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] regulator: pf9453: Fix=
 kernel doc for mux_poll()
> # good: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] spi: imx: remove CLK c=
alculation and check for target mode
> # good: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] ASoC: SDCA: support Q7=
=2E8 volume format
> # good: [655079ac8a7721ac215a0596e3f33b740e01144a] ASoC: qcom: q6asm: Use=
 guard() for spin locks
> # good: [3c36965df80801344850388592e95033eceea05b] regulator: Add support=
 for MediaTek MT6363 SPMI PMIC Regulators
> # good: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] ASoC: dt-bindings: ti,=
pcm1862: convert to dtschema
> # good: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] spi: aspeed: Use devm_=
iounmap() to unmap devm_ioremap() memory
> # good: [c4e68959af66df525d71db619ffe44af9178bb22] ASoC: dt-bindings: ti,=
tas2781: Add TAS5822 support
> # good: [af9c8092d84244ca54ffb590435735f788e7a170] regmap: i3c: Use ARRAY=
_SIZE()
> # good: [380fd29d57abe6679d87ec56babe65ddc5873a37] spi: tegra210-quad: Ch=
eck hardware status on timeout
> # good: [2ecc8c089802e033d2e5204d21a9f467e2517df9] regulator: pf9453: rem=
ove unused I2C_LT register
> # good: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] regulator: Small clean=
up in of_get_regulation_constraints()
> # good: [84194c66aaf78fed150edb217b9f341518b1cba2] ASoC: codecs: aw88261:=
 pass pointer directly instead of passing the address
> # good: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] regcache: maple: Split=
 ->populate() from ->init()
> # good: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] ASoC: codec: wm8400: r=
eplace printk() calls with dev_*() device aware logging
> # good: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] spi: tle62x0: Add newl=
ine to sysfs attribute output
> # good: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] ASoC: max98090/91: fix=
ing the stream index
> # good: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] ASoC: soc-core: check =
ops & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereferen=
ce error
> # good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro=
: fix revision checking
> # good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: ma=
ke use of common helpers
> # good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add supp=
ort for the external mclk
> # good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove ob=
solete file entry in DIALOG SEMICONDUCTOR DRIVERS
> # good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users abo=
ut uninitialized flat cache
> # good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fa=
ilure check for spacemit_i2s_init_dai()
> # good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `d=
epends on` instead of `select`
> # good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Sup=
port SPDIF output on A523 family
> # good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test:=
 Add test cases for cs_amp_set_efi_calibration_data()
> # good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID bu=
tton IRQ
> # good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: li=
nk regulator inputs to supply groups
> # good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace ex=
ec_op
> # good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspber=
rypi drivers depend on ARM
> # good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Co=
nstify struct fsi_stream_handler
> # good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI =
bus support for cs530x parts
> # good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: ad=
d qrb2210-sndcard compatible string
> # good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add n=
ame_prefix for rt1321 part id
> # good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: m=
ake qcom_spi_ecc_engine_ops_pipelined const
> # good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regula=
tor: Add RPMH regulator support for PMR735D
> # good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: add=
ing DAPM routing for digital output for max98091
> # good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fix=
ing a space
> # good: [638bae3fb225a708dc67db613af62f6d14c4eff4] ASoC: max98090/91: add=
ed DAPM widget for digital output for max98091
> # good: [ecba655bf54a661ffe078856cd8dbc898270e4b5] ASoC: fsl_aud2htx: add=
 IEC958_SUBFRAME_LE format in supported list
> # good: [7e1906643a7374529af74b013bba35e4fa4e6ffc] ASoC: codecs: va-macro=
: Clean up on error path in probe()
> # good: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] ASoC: soc.h: remove sn=
d_soc_kcontrol_component()
> # good: [6658472a3e2de08197acfe099ba71ee0e2505ecf] ASoC: amd: amd_sdw: Pr=
opagate the PCI subsystem Vendor and Device IDs
> # good: [fce217449075d59b29052b8cdac567f0f3e22641] ASoC: spacemit: add i2=
s support for K1 SoC
> # good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS=
_ERR() vs NULL bug in probe()
> # good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer mu=
st be 0xff-ed before writing
> # good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spell=
ing mistake "triming" -> "trimming"
> # good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qco=
m: Add Kaanapali LPASS macro codecs
> # good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: suppor=
t usage with simple-audio-card
> # good: [fb25114cd760c13cf177d9ac37837fafcc9657b5] regulator: sy7636a: ad=
d gpios and input regulator
> # good: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] ASoC: codecs: rt5670: =
use SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
> # good: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] regulator: rpmh-regula=
tor: Add RPMH regulator support for Glymur
> # good: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] ASoC: replace use of s=
ystem_wq with system_dfl_wq
> # good: [433e294c3c5b5d2020085a0e36c1cb47b694690a] regulator: core: forwa=
rd undervoltage events downstream by default
> # good: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] x86/module: Improve re=
location error messages
> # good: [c2d420796a427dda71a2400909864e7f8e037fd4] elfnote: Change ELFNOT=
E() to use __UNIQUE_ID()
> # good: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] ASoC: sof-function-top=
ology-lib: escalate the log when missing function topoplogy
> # good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-top=
ology-lib: escalate the log when missing function topoplogy
> # good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map =
necessary address window region
> # good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-=
qpic-snand: Add IPQ5332 compatible
> # good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the =
error of excessive semicolons
> # good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mo=
de support
> # good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Up=
date ADMAIF bindings for tegra264
> # good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offs=
et parameter
> # good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings=
: Convert Dialog DA9211 Regulators to DT schema
> # good: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] Merge branch 'next/dri=
vers' into for-next
> git bisect start '92fd6e84175befa1775e5c0ab682938eca27c0b2' '07e9a6847830=
2d35f3372ac8c9994d679a9cfdca' 'cb99656b7c4185953c9d272bbdab63c8aa651e6e' 'd=
f919994d323c7c86e32fa2745730136d58ada12' '670500b41e543c5cb09eb9f7f0e4e26c5=
b5fdf7e' '3af1815a2f9caebfc666af3912e24d030a5368d5' '3efee7362dbf896072af1c=
1aaeaf9fd6e235c591' 'f1c668269ded16bea32a11d03f4584caa0c018c9' '43a3adb6dd3=
9d98bf84e04569e7604be5e5c0d79' '33822d795ab93067d9a65f42003c0d01c65d4a9d' '=
d5089fffe1db04a802b028c2ef4875be1ed452a3' '12d821bd13d42e6de3ecb1c13918b1f0=
6a3ee213' '3045e29d248bde2a68da425498a656093ee0df69' 'bdf96e9135a0cf53a853a=
19c30fa11131a744062' 'e2c48498a93404743e0565dcac29450fec02e6a3' '7a0a877121=
20329c034b0aae88bdaa05bd046f10' 'b871d9adffe5a64a1fd9edcb1aebbcc995b17901' =
'd9813cd23d5a7b254cc1b1c1ea042634d8da62e6' 'e45979641a9a9dbb48fc77c5b36a509=
1a92e7227' 'd218ea171430e49412804efb794942dd121a8032' '21e68bcb1b0c688c2d9c=
a0d457922febac650ac1' 'bd79452b39c21599e2cff42e9fbeb182656b6f6a' '96498e804=
cb6629e02747336a0a33e4955449732' '9e510e677090bb794b46348b10e1c8038286e00a'=
 '4422df6782eb7aa9725a3c09d9ba3c38ecc85df4' 'd5c8b7902a41625ea328b52c78ebe7=
50fbf6fef7' '118eb2cb97b8fc0d515bb0449495959247db58f0' 'f7ae6d4ec6520a90178=
7cbab273983e96d8516da' '079115370d00c78ef69b31dd15def90adf2aa579' '059f5458=
32be85d29ac9ccc416a16f647aa78485' '6402ddf3027d8975f135cf2b2014d6bbeb2d3436=
' '4e00135b2dd1d7924a58bffa551b6ceb3bd836f2' '8ff3dcb0e8a8bf6c41f23ed4aa62d=
066d3948a10' '8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860' 'e65b871c9b5af9265a=
efc5b8cd34993586d93aab' '123cd174a3782307787268adf45f22de4d290128' '1d562ba=
0aa7df81335bf96c02be77efe8d5bab87' '4d6e2211aeb932e096f673c88475016b1cc0f8a=
b' '32172cf3cb543a04c41a1677c97a38e60cad05b6' '873bc94689d832878befbcadc10b=
6ad5bb4e0027' 'b3a5302484033331af37569f7277d00131694b57' '772ada50282b0c803=
43c8989147db816961f571d' 'fb1ebb10468da414d57153ddebaab29c38ef1a78' '6985de=
fd1d832f1dd9d1977a6a2cc2cef7632704' '6951be397ca8b8b167c9f99b5a11c541148c38=
cb' '4e92abd0a11b91af3742197a9ca962c3c00d0948' '2089f086303b773e181567fd8d5=
df3038bd85937' 'abc9a349b87ac0fd3ba8787ca00971b59c2e1257' '6bd1ad97eb790570=
c167d4de4ca59fbc9c33722a' '55d03b5b5bdd04daf9a35ce49db18d8bb488dffb' '1b0f3=
f9ee41ee2bdd206667f85ea2aa36dfe6e69' '655079ac8a7721ac215a0596e3f33b740e011=
44a' '3c36965df80801344850388592e95033eceea05b' 'aa897ffc396b48cc39eee133b6=
b43175d0df9eb5' '2f538ef9f6f7c3d700c68536f21447dfc598f8c8' 'c4e68959af66df5=
25d71db619ffe44af9178bb22' 'af9c8092d84244ca54ffb590435735f788e7a170' '380f=
d29d57abe6679d87ec56babe65ddc5873a37' '2ecc8c089802e033d2e5204d21a9f467e251=
7df9' '252abf2d07d33b1c70a59ba1c9395ba42bbd793e' '84194c66aaf78fed150edb217=
b9f341518b1cba2' 'ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc' '6ef8e042cdcaab=
e3e3c68592ba8bfbaee2fa10a3' 'ecd0de438c1f0ee86cf8f6d5047965a2a181444b' 'f1d=
fbc1b5cf8650ae9a0d543e5f5335fc0f478ce' 'e73b743bfe8a6ff4e05b5657d3f7586a17a=
c3ba0' '20bcda681f8597e86070a4b3b12d1e4f541865d3' '8fdb030fe283c84fd8d378c9=
7ad0f32d6cdec6ce' 'cf6bf51b53252284bafc7377a4d8dbf10f048b4d' '28039efa4d8e8=
bbf98b066133a906bd4e307d496' 'e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8' 'f0=
34c16a4663eaf3198dc18b201ba50533fb5b81' '66fecfa91deb536a12ddf3d878a99590d7=
900277' '4a5ac6cd05a7e54f1585d7779464d6ed6272c134' '4795375d8aa072e9aacb0b2=
78e6203c6ca41816a' 'ef042df96d0e1089764f39ede61bc8f140a4be00' '4c33cef58965=
eb655a0ac8e243aa323581ec025f' '77a58ba7c64ccca20616aa03599766ccb0d1a330' '0=
1313661b248c5ba586acae09bff57077dbec0a5' 'd29479abaded34b2b1dab2e17efe96a65=
eba3d61' 'e7434adf0c53a84d548226304cdb41c8818da1cb' 'e973dfe9259095fb509ab1=
2658c68d46f0e439d7' 'c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c' 'fd5ef3d69f8=
975bad16c437a337b5cb04c8217a2' 'd054cc3a2ccfb19484f3b54d69b6e416832dc8f4' '=
2528c15f314ece50218d1273654f630d74109583' '310bf433c01f78e0756fd5056a43118a=
2f77318c' '638bae3fb225a708dc67db613af62f6d14c4eff4' 'ecba655bf54a661ffe078=
856cd8dbc898270e4b5' '7e1906643a7374529af74b013bba35e4fa4e6ffc' 'd742ebcfe5=
24dc54023f7c520d2ed2e4b7203c19' '6658472a3e2de08197acfe099ba71ee0e2505ecf' =
'fce217449075d59b29052b8cdac567f0f3e22641' '0cc08c8130ac8f74419f99fe707dc19=
3b7f79d86' '0743acf746a81e0460a56fd5ff847d97fa7eb370' 'd77daa49085b067137d0=
adbe3263f75a7ee13a1b' '15afe57a874eaf104bfbb61ec598fa31627f7b19' '1e570e773=
92f43a3cdab2849d1f81535f8a033e2' 'fb25114cd760c13cf177d9ac37837fafcc9657b5'=
 '6621b0f118d500092f5f3d72ddddb22aeeb3c3a0' '65efe5404d151767653c7b7dd39bd2=
e7ad532c2d' '0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4' '433e294c3c5b5d20200=
85a0e36c1cb47b694690a' 'bf770d6d2097a52d87f4d9c88d0b05bd3998d7de' 'c2d42079=
6a427dda71a2400909864e7f8e037fd4' '7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd=
' '9797329220a2c6622411eb9ecf6a35b24ce09d04' '64d87ccfae3326a9561fe41dc6073=
064a083e0df' '4412ab501677606436e5c49e41151a1e6eac7ac0' '5e537031f322d55315=
cd384398b726a9a0748d47' 'fe8cc44dd173cde5788ab4e3730ac61f3d316d9c' '4d410ba=
9aa275e7990a270f63ce436990ace1bea' 'b83fb1b14c06bdd765903ac852ba20a14e24f22=
7' '6277a486a7faaa6c87f4bf1d59a2de233a093248' '6c177775dcc5e70a64ddf4ee842c=
66af498f2c7c'
> # test job: [cb99656b7c4185953c9d272bbdab63c8aa651e6e] https://lava.siren=
a.org.uk/scheduler/job/2132762
> # test job: [df919994d323c7c86e32fa2745730136d58ada12] https://lava.siren=
a.org.uk/scheduler/job/2121710
> # test job: [670500b41e543c5cb09eb9f7f0e4e26c5b5fdf7e] https://lava.siren=
a.org.uk/scheduler/job/2121053
> # test job: [3af1815a2f9caebfc666af3912e24d030a5368d5] https://lava.siren=
a.org.uk/scheduler/job/2115465
> # test job: [3efee7362dbf896072af1c1aaeaf9fd6e235c591] https://lava.siren=
a.org.uk/scheduler/job/2115125
> # test job: [f1c668269ded16bea32a11d03f4584caa0c018c9] https://lava.siren=
a.org.uk/scheduler/job/2113592
> # test job: [43a3adb6dd39d98bf84e04569e7604be5e5c0d79] https://lava.siren=
a.org.uk/scheduler/job/2115050
> # test job: [33822d795ab93067d9a65f42003c0d01c65d4a9d] https://lava.siren=
a.org.uk/scheduler/job/2112459
> # test job: [d5089fffe1db04a802b028c2ef4875be1ed452a3] https://lava.siren=
a.org.uk/scheduler/job/2111799
> # test job: [12d821bd13d42e6de3ecb1c13918b1f06a3ee213] https://lava.siren=
a.org.uk/scheduler/job/2112898
> # test job: [3045e29d248bde2a68da425498a656093ee0df69] https://lava.siren=
a.org.uk/scheduler/job/2111763
> # test job: [bdf96e9135a0cf53a853a19c30fa11131a744062] https://lava.siren=
a.org.uk/scheduler/job/2109740
> # test job: [e2c48498a93404743e0565dcac29450fec02e6a3] https://lava.siren=
a.org.uk/scheduler/job/2107365
> # test job: [7a0a87712120329c034b0aae88bdaa05bd046f10] https://lava.siren=
a.org.uk/scheduler/job/2107534
> # test job: [b871d9adffe5a64a1fd9edcb1aebbcc995b17901] https://lava.siren=
a.org.uk/scheduler/job/2107898
> # test job: [d9813cd23d5a7b254cc1b1c1ea042634d8da62e6] https://lava.siren=
a.org.uk/scheduler/job/2105382
> # test job: [e45979641a9a9dbb48fc77c5b36a5091a92e7227] https://lava.siren=
a.org.uk/scheduler/job/2104425
> # test job: [d218ea171430e49412804efb794942dd121a8032] https://lava.siren=
a.org.uk/scheduler/job/2104309
> # test job: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] https://lava.siren=
a.org.uk/scheduler/job/2104503
> # test job: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] https://lava.siren=
a.org.uk/scheduler/job/2104088
> # test job: [96498e804cb6629e02747336a0a33e4955449732] https://lava.siren=
a.org.uk/scheduler/job/2099747
> # test job: [9e510e677090bb794b46348b10e1c8038286e00a] https://lava.siren=
a.org.uk/scheduler/job/2093874
> # test job: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] https://lava.siren=
a.org.uk/scheduler/job/2097746
> # test job: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] https://lava.siren=
a.org.uk/scheduler/job/2092719
> # test job: [118eb2cb97b8fc0d515bb0449495959247db58f0] https://lava.siren=
a.org.uk/scheduler/job/2092527
> # test job: [f7ae6d4ec6520a901787cbab273983e96d8516da] https://lava.siren=
a.org.uk/scheduler/job/2122586
> # test job: [079115370d00c78ef69b31dd15def90adf2aa579] https://lava.siren=
a.org.uk/scheduler/job/2121428
> # test job: [059f545832be85d29ac9ccc416a16f647aa78485] https://lava.siren=
a.org.uk/scheduler/job/2086759
> # test job: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] https://lava.siren=
a.org.uk/scheduler/job/2086593
> # test job: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] https://lava.siren=
a.org.uk/scheduler/job/2082522
> # test job: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] https://lava.siren=
a.org.uk/scheduler/job/2083115
> # test job: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] https://lava.siren=
a.org.uk/scheduler/job/2082575
> # test job: [e65b871c9b5af9265aefc5b8cd34993586d93aab] https://lava.siren=
a.org.uk/scheduler/job/2083139
> # test job: [123cd174a3782307787268adf45f22de4d290128] https://lava.siren=
a.org.uk/scheduler/job/2078963
> # test job: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] https://lava.siren=
a.org.uk/scheduler/job/2078345
> # test job: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] https://lava.siren=
a.org.uk/scheduler/job/2077998
> # test job: [32172cf3cb543a04c41a1677c97a38e60cad05b6] https://lava.siren=
a.org.uk/scheduler/job/2075069
> # test job: [873bc94689d832878befbcadc10b6ad5bb4e0027] https://lava.siren=
a.org.uk/scheduler/job/2074834
> # test job: [b3a5302484033331af37569f7277d00131694b57] https://lava.siren=
a.org.uk/scheduler/job/2074543
> # test job: [772ada50282b0c80343c8989147db816961f571d] https://lava.siren=
a.org.uk/scheduler/job/2069185
> # test job: [fb1ebb10468da414d57153ddebaab29c38ef1a78] https://lava.siren=
a.org.uk/scheduler/job/2059783
> # test job: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] https://lava.siren=
a.org.uk/scheduler/job/2059123
> # test job: [6951be397ca8b8b167c9f99b5a11c541148c38cb] https://lava.siren=
a.org.uk/scheduler/job/2055768
> # test job: [4e92abd0a11b91af3742197a9ca962c3c00d0948] https://lava.siren=
a.org.uk/scheduler/job/2055839
> # test job: [2089f086303b773e181567fd8d5df3038bd85937] https://lava.siren=
a.org.uk/scheduler/job/2058048
> # test job: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] https://lava.siren=
a.org.uk/scheduler/job/2054610
> # test job: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] https://lava.siren=
a.org.uk/scheduler/job/2053444
> # test job: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] https://lava.siren=
a.org.uk/scheduler/job/2053865
> # test job: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] https://lava.siren=
a.org.uk/scheduler/job/2053663
> # test job: [655079ac8a7721ac215a0596e3f33b740e01144a] https://lava.siren=
a.org.uk/scheduler/job/2049712
> # test job: [3c36965df80801344850388592e95033eceea05b] https://lava.siren=
a.org.uk/scheduler/job/2049474
> # test job: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] https://lava.siren=
a.org.uk/scheduler/job/2048775
> # test job: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] https://lava.siren=
a.org.uk/scheduler/job/2048626
> # test job: [c4e68959af66df525d71db619ffe44af9178bb22] https://lava.siren=
a.org.uk/scheduler/job/2044018
> # test job: [af9c8092d84244ca54ffb590435735f788e7a170] https://lava.siren=
a.org.uk/scheduler/job/2043675
> # test job: [380fd29d57abe6679d87ec56babe65ddc5873a37] https://lava.siren=
a.org.uk/scheduler/job/2044558
> # test job: [2ecc8c089802e033d2e5204d21a9f467e2517df9] https://lava.siren=
a.org.uk/scheduler/job/2038640
> # test job: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] https://lava.siren=
a.org.uk/scheduler/job/2038545
> # test job: [84194c66aaf78fed150edb217b9f341518b1cba2] https://lava.siren=
a.org.uk/scheduler/job/2038391
> # test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.siren=
a.org.uk/scheduler/job/2029011
> # test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.siren=
a.org.uk/scheduler/job/2025855
> # test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.siren=
a.org.uk/scheduler/job/2026095
> # test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.siren=
a.org.uk/scheduler/job/2025515
> # test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.siren=
a.org.uk/scheduler/job/2026430
> # test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.siren=
a.org.uk/scheduler/job/2022992
> # test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.siren=
a.org.uk/scheduler/job/2021461
> # test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.siren=
a.org.uk/scheduler/job/2023022
> # test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.siren=
a.org.uk/scheduler/job/2020298
> # test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.siren=
a.org.uk/scheduler/job/2020171
> # test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.siren=
a.org.uk/scheduler/job/2015463
> # test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.siren=
a.org.uk/scheduler/job/2015316
> # test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.siren=
a.org.uk/scheduler/job/2011270
> # test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.siren=
a.org.uk/scheduler/job/2009695
> # test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.siren=
a.org.uk/scheduler/job/2010161
> # test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.siren=
a.org.uk/scheduler/job/2009455
> # test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.siren=
a.org.uk/scheduler/job/2007308
> # test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.siren=
a.org.uk/scheduler/job/2008765
> # test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.siren=
a.org.uk/scheduler/job/2008428
> # test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.siren=
a.org.uk/scheduler/job/2007796
> # test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.siren=
a.org.uk/scheduler/job/2008129
> # test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.siren=
a.org.uk/scheduler/job/2000031
> # test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.siren=
a.org.uk/scheduler/job/1996145
> # test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.siren=
a.org.uk/scheduler/job/1995770
> # test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.siren=
a.org.uk/scheduler/job/1997626
> # test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.siren=
a.org.uk/scheduler/job/1996060
> # test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.siren=
a.org.uk/scheduler/job/1991896
> # test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.siren=
a.org.uk/scheduler/job/1985168
> # test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.siren=
a.org.uk/scheduler/job/1978655
> # test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.siren=
a.org.uk/scheduler/job/1975982
> # test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.siren=
a.org.uk/scheduler/job/1973471
> # test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.siren=
a.org.uk/scheduler/job/1975680
> # test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.siren=
a.org.uk/scheduler/job/1965719
> # test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.siren=
a.org.uk/scheduler/job/1964863
> # test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.siren=
a.org.uk/scheduler/job/1962771
> # test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.siren=
a.org.uk/scheduler/job/1962956
> # test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.siren=
a.org.uk/scheduler/job/1962292
> # test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.siren=
a.org.uk/scheduler/job/1960167
> # test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.siren=
a.org.uk/scheduler/job/1959744
> # test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.siren=
a.org.uk/scheduler/job/1959976
> # test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.siren=
a.org.uk/scheduler/job/1957385
> # test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.siren=
a.org.uk/scheduler/job/1957438
> # test job: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] https://lava.siren=
a.org.uk/scheduler/job/1990586
> # test job: [c2d420796a427dda71a2400909864e7f8e037fd4] https://lava.siren=
a.org.uk/scheduler/job/1990667
> # test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.siren=
a.org.uk/scheduler/job/1954263
> # test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.siren=
a.org.uk/scheduler/job/1947395
> # test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.siren=
a.org.uk/scheduler/job/1947254
> # test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.siren=
a.org.uk/scheduler/job/1946284
> # test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.siren=
a.org.uk/scheduler/job/1946643
> # test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.siren=
a.org.uk/scheduler/job/1946090
> # test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.siren=
a.org.uk/scheduler/job/1947752
> # test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.siren=
a.org.uk/scheduler/job/1946838
> # test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.siren=
a.org.uk/scheduler/job/1947021
> # test job: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] https://lava.siren=
a.org.uk/scheduler/job/2122930
> # test job: [92fd6e84175befa1775e5c0ab682938eca27c0b2] https://lava.siren=
a.org.uk/scheduler/job/2134811
> # bad: [92fd6e84175befa1775e5c0ab682938eca27c0b2] Add linux-next specific=
 files for 20251125
> git bisect bad 92fd6e84175befa1775e5c0ab682938eca27c0b2
> # test job: [bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0] https://lava.siren=
a.org.uk/scheduler/job/2134897
> # bad: [bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0] Merge branch 'master' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git
> git bisect bad bfda4f7f7c8a71d3fa9e0e062f64e3e03b401ce0
> # test job: [27bc91de97549dcf3983f68c90e1d25244e75e67] https://lava.siren=
a.org.uk/scheduler/job/2135008
> # good: [27bc91de97549dcf3983f68c90e1d25244e75e67] Merge branch 'next' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
> git bisect good 27bc91de97549dcf3983f68c90e1d25244e75e67
> # test job: [11354ae4fd8605c56deed3aa9e17083a75209455] https://lava.siren=
a.org.uk/scheduler/job/2135187
> # bad: [11354ae4fd8605c56deed3aa9e17083a75209455] Merge branch 'next' of =
git://linuxtv.org/media-ci/media-pending.git
> git bisect bad 11354ae4fd8605c56deed3aa9e17083a75209455
> # test job: [6dcee998bc550ca1f4d93ada88ddf3ddf88278b5] https://lava.siren=
a.org.uk/scheduler/job/2135222
> # bad: [6dcee998bc550ca1f4d93ada88ddf3ddf88278b5] Merge branch 'vfs.all' =
of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> git bisect bad 6dcee998bc550ca1f4d93ada88ddf3ddf88278b5
> # test job: [4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c] https://lava.siren=
a.org.uk/scheduler/job/2135273
> # bad: [4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c] Merge branch 'vfs-6.19.=
fd_prepare' into vfs.all
> git bisect bad 4d8cb2518d6f29e24b1df6609ee32cab7e76aa7c
> # test job: [fbcf11d2838ae1df75ef10856e31fbbdd001baa5] https://lava.siren=
a.org.uk/scheduler/job/2135310
> # good: [fbcf11d2838ae1df75ef10856e31fbbdd001baa5] Merge branch 'namespac=
e-6.19' into vfs.all
> git bisect good fbcf11d2838ae1df75ef10856e31fbbdd001baa5
> # test job: [5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16] https://lava.siren=
a.org.uk/scheduler/job/2135396
> # good: [5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16] Merge branch 'vfs-6.19=
=2Edirectory.delegations' into vfs.all
> git bisect good 5d1eb038b7d7bc0262cb153f84a6cdec4b95ba16
> # test job: [d6ef072d09b2341e606aeeaf14c3510dec329c63] https://lava.siren=
a.org.uk/scheduler/job/2135491
> # good: [d6ef072d09b2341e606aeeaf14c3510dec329c63] ovl: reflow ovl_create=
_or_link()
> git bisect good d6ef072d09b2341e606aeeaf14c3510dec329c63
> # test job: [b27548e6abcc0d771eda10b8ed5aaac5d53ef421] https://lava.siren=
a.org.uk/scheduler/job/2135564
> # good: [b27548e6abcc0d771eda10b8ed5aaac5d53ef421] spufs: convert spufs_c=
ontext_open() to FD_PREPARE()
> git bisect good b27548e6abcc0d771eda10b8ed5aaac5d53ef421
> # test job: [fd9bdc258e6208fb635c3d4a9980c143f77121f1] https://lava.siren=
a.org.uk/scheduler/job/2135723
> # bad: [fd9bdc258e6208fb635c3d4a9980c143f77121f1] Merge patch series "fil=
e: FD_{ADD,PREPARE}()"
> git bisect bad fd9bdc258e6208fb635c3d4a9980c143f77121f1
> # test job: [c2d378132453fd94cec4e3cde29e768b698fb388] https://lava.siren=
a.org.uk/scheduler/job/2135963
> # good: [c2d378132453fd94cec4e3cde29e768b698fb388] media: convert media_r=
equest_alloc() to FD_PREPARE()
> git bisect good c2d378132453fd94cec4e3cde29e768b698fb388
> # test job: [ce7194bb784d673e916315e1610d444d6dd03f10] https://lava.siren=
a.org.uk/scheduler/job/2136299
> # bad: [ce7194bb784d673e916315e1610d444d6dd03f10] file: convert replace_f=
d() to FD_PREPARE()
> git bisect bad ce7194bb784d673e916315e1610d444d6dd03f10
> # test job: [d624684412e7f1530950d4ca9aa792d55a83c381] https://lava.siren=
a.org.uk/scheduler/job/2136587
> # bad: [d624684412e7f1530950d4ca9aa792d55a83c381] tty: convert ptm_open_p=
eer() to FD_ADD()
> git bisect bad d624684412e7f1530950d4ca9aa792d55a83c381
> # test job: [aa24d422e21f64f006988ad1f6a39013d7d085f5] https://lava.siren=
a.org.uk/scheduler/job/2136750
> # good: [aa24d422e21f64f006988ad1f6a39013d7d085f5] ntsync: convert ntsync=
_obj_get_fd() to FD_PREPARE()
> git bisect good aa24d422e21f64f006988ad1f6a39013d7d085f5
> # first bad commit: [d624684412e7f1530950d4ca9aa792d55a83c381] tty: conve=
rt ptm_open_peer() to FD_ADD()



