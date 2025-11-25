Return-Path: <linux-fsdevel+bounces-69831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A306C86B02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4249E4E959A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B3332908;
	Tue, 25 Nov 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ju8/U9rD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39503321DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096185; cv=none; b=nu2blRg0SoZmj+7TBxRwxrOoY64e9NXeDe+rglrS35NUqyMAMI/VGBVDsPJBdiYw0rm6VY3/MMl7RbacINmo9m5XLF62PWnufLhq0AXQEkGCH3DjI8bb5S19m0q10tknSnEOAYoGTJSYSNUnylKVtSrMF56QpaW8i0UuPg2uSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096185; c=relaxed/simple;
	bh=J5yb/UC1A7vYdK0jmfuKjigsoEcRGW2DZN91dhTvAqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpRRYaKoRsdJjIhyGKFuuJ2rZ6iGO3y69Go3MlBwAQ6kxCbHoKspXodqf2/COn76ZVOToCG9taG55ppHGc7gyg70m6HCRuuFl0ehZlVwGKtpf3gj8RoeGH5qzh8jxn/zmBWmxsmJcntkufr/EN6Pq0tSV2bJkpsJB+3ilj6MlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ju8/U9rD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735e278fa1so575195766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764096182; x=1764700982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sl7d4yuCxVIIt38N0Zrxf3gnAJfLpB9v0r3s+kB8/4=;
        b=ju8/U9rDg0IM6nszTbDpgE9ubWDJ2+H1pKU/AACHauBECgfXoeUZMACBVS3uGTnWol
         3Aj1WJum91nFhIAvnmUEz7nclIdS99TQLCH9lDHe3JqMbQZO3zJHs3IkhgMjrG3G4Dba
         lhdUYApv0BrtwlNn5WvncJp2u8mq4pZOdH1mr9DwaJNkW1cBEAqZL2Ow3kJdvHD5xlQU
         kz1vWxuxw/yJfg5AhbHhQ25mBqed6YIhYOxf//YyAKzF+pAlaq9kXT/wA5tl/p9JTCN+
         S1/5saxl/MIdGafGtyUdJZo4oba/NybJq64fF85YtlbQ7EQ1alB8FQYKSjmD7jMsXJer
         58vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764096182; x=1764700982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sl7d4yuCxVIIt38N0Zrxf3gnAJfLpB9v0r3s+kB8/4=;
        b=uugKaLcuU7tcyFMHKl8evoE8i3U3VaiaKVQPz+CsyxiSVS5IGdR6aeY7VoUxQeEsTs
         XBUFyDlrfxovA8Kr21VNNdJcDu7qb9wsDdfuIL87ypqQHp61cwo4hP7qEtbzC6KjlfmB
         vzFxPJQudD/vZImc3cxd1ntwRjC0IuCok5vwfMLfXub3EPP+1aNkOrzVmnt/Toec7+bI
         +6lAQI03G7Ksx3Jr12L9ls1KSLBc1AmeJkEwAmQm00j3N7PH21d2clXT2i950g+MJewt
         TGpouE8jfJgKD2/5jIbKoieqE6YEtDNmFAnwIcBkdhfUZKnD3V03oaqc3Yyg8UHF0Gwo
         op0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4dO6ONucDH6MWrqNjaVJra+mhGVquc5Kf9dQ2LV22YhwN5TrlkKCL3NHlz9N12zB7zX40WNyFomHwG6kp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz667QqAZd9cAspkOGZKXPC0tOOCAU6iyjfkcUH0YwQJRbLD8PZ
	U0D1B4NHsZBMBF65f3vI+hZnZ1FkEiV+iK+S9aI0EWA1BupoH3zyGNq83eY/9pNCbixaDCDJabj
	cftBU319EunNhmoDPk/1B/hUM0exffIh8uT6A/B2Vsg==
X-Gm-Gg: ASbGncvjYnuAT/ZlDKzXLjqMpyQ9IPYp84OoIAtRh+UL9F4iQ+WUYKpk6lV2gz9A5bo
	h8dq4UM/RmZEBgBgeHLjGidPwpjdL0QrzeZ+m5RQXQ7JlXc45u+KXYfF9ScT3u7DHtg1aozDXjw
	VqgawmteyAB0ZKmzLRozmn1mWsqMs7qZzJKlkoTTuf1gicZhgVi5QQfcs/dtqju4wcV5ukpaWWK
	niSdlB4uWKLGMm02aSmnux3wXvIyorMKioNg2K5dJijdmNRwhG1vSAvdD9bTHXOMhB/
X-Google-Smtp-Source: AGHT+IGSMJtx2bO2sylBPLFg9TBSoq5VimU44LG0EK6+xX3ux9ORu14DJvucOQEenuC++UueKyTADqq7bGyGwdliFos=
X-Received: by 2002:a17:906:240e:b0:b76:d825:caca with SMTP id
 a640c23a62f3a-b76d825cd38mr74808366b.38.1764096181962; Tue, 25 Nov 2025
 10:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-20-pasha.tatashin@soleen.com> <aSQPNuFIv0rRr2tp@kernel.org>
In-Reply-To: <aSQPNuFIv0rRr2tp@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 13:42:25 -0500
X-Gm-Features: AWmQ_bnIS98IIm55LCZoBkdO3g3lJwbqWrOuaBnNVwpmXpd9QYlsv3e6UPqSTqM
Message-ID: <CA+CK2bAWe15SkcvWx_hRHvT-RAcudKQ1hRV1htuWanh9Mbh_YA@mail.gmail.com>
Subject: Re: [PATCH v7 19/22] selftests/liveupdate: add test infrastructure
 and scripts
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 2:54=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:46PM -0500, Pasha Tatashin wrote:
> > Subject: [PATCH v7 19/22] selftests/liveupdate: add test infrastructure=
 and scripts
>
> Maybe                                                ^ end to end

Done.

>
> > Add the testing infrastructure required to verify the liveupdate
> > feature. This includes a custom init process, a test orchestration
> > script, and a batch runner.
>
> And say here that it's end to end test.

Done

> > +static int is_stage_2(void)
> > +{
> > +     char cmdline[COMMAND_LINE_SIZE];
> > +     ssize_t len;
> > +     int fd;
> > +
> > +     fd =3D open("/proc/cmdline", O_RDONLY);
> > +     if (fd < 0)
> > +             return 0;
> > +
> > +     len =3D read(fd, cmdline, sizeof(cmdline) - 1);
> > +     close(fd);
> > +
> > +     if (len < 0)
> > +             return 0;
>
> Shouldn't we bail out of the test if read of command line failed?

Sure, done.

> > +function cleanup() {
> > +     local exit_code=3D$?
> > +
> > +     if [ -z "$workspace_dir" ]; then
> > +             ktap_finished
> > +             return
> > +     fi
> > +
> > +     if [ $exit_code -ne 0 ]; then
> > +             echo "# Test failed (exit code $exit_code)."
> > +             echo "# Workspace preserved at: $workspace_dir"
> > +     elif [ "$KEEP_WORKSPACE" -eq 1 ]; then
> > +             echo "# Workspace preserved (user request) at: $workspace=
_dir"
> > +     else
> > +             rm -fr "$workspace_dir"
> > +     fi
> > +     ktap_finished
>
>         exit $exit_code

Done

> > +function build_kernel() {
> > +     local build_dir=3D$1
> > +     local make_cmd=3D$2
> > +     local kimage=3D$3
> > +     local target_arch=3D$4
> > +
> > +     local kconfig=3D"$build_dir/.config"
> > +     local common_conf=3D"$test_dir/config"
> > +     local arch_conf=3D"$test_dir/config.$target_arch"
> > +
> > +     echo "# Building kernel in: $build_dir"
> > +     $make_cmd defconfig
> > +
> > +     local fragments=3D""
> > +     if [[ -f "$common_conf" ]]; then
> > +             fragments=3D"$fragments $common_conf"
> > +     fi
>
> Without this CONFIG_LIVEUPDATE won't be set
> > +
> > +     if [[ -f "$arch_conf" ]]; then
> > +             fragments=3D"$fragments $arch_conf"
> > +     fi
> > +
> > +     if [[ -n "$fragments" ]]; then
> > +             "$kernel_dir/scripts/kconfig/merge_config.sh" \
> > +                     -Q -m -O "$build_dir" "$kconfig" $fragments >> /d=
ev/null
> > +     fi
>
> I believe you can just
>
>         cat $common_conf $fragments >  $build_dir/.config
>         make olddefconfig
>
> without running defconfig at the beginning
> It will build faster, just make sure to add CONFIG_SERIAL_ to $arch_conf

I will look into that, so how performance really changes,  I liked
using merge_config.sh as it does not print warnings.

>
> > +     $make_cmd olddefconfig
> > +     $make_cmd "$kimage"
> > +     $make_cmd headers_install INSTALL_HDR_PATH=3D"$headers_dir"
> > +}
> > +
> > +function mkinitrd() {
> > +     local build_dir=3D$1
> > +     local kernel_path=3D$2
> > +     local test_name=3D$3
> > +
> > +     # 1. Compile the test binary and the init process
>
> Didn't find 2. ;-)
> Don't think we want the numbering here, plain comments are fine

Updated comment.


>
> > +     "$CROSS_COMPILE"gcc -static -O2 \
> > +             -I "$headers_dir/include" \
> > +             -I "$test_dir" \
> > +             -o "$workspace_dir/test_binary" \
> > +             "$test_dir/$test_name.c" "$test_dir/luo_test_utils.c"
>
> This will have hard time cross-compiling with -nolibc toolchains

Hm, it works for me, I am not sure with nolibc cross compiler, am I
missing something?

>
> > +
> > +     "$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib          \
> > +                     -fno-asynchronous-unwind-tables -fno-ident      \
> > +                     -fno-stack-protector                            \
> > +                     -I "$headers_dir/include"                       \
> > +                     -I "$kernel_dir/tools/include/nolibc"           \
> > +                     -o "$workspace_dir/init" "$test_dir/init.c"
>
> This failed for me with gcc 14.2.0 (Debian 14.2.0-19):


Updated, removed the extra const, and static.

>
> /home/mike/git/linux/tools/testing/selftests/liveupdate/init.c: In functi=
on =E2=80=98run_test=E2=80=99:
> /home/mike/git/linux/tools/testing/selftests/liveupdate/init.c:111:65: er=
ror: initializer element is not constant
>   111 |             static const char *const argv[] =3D {TEST_BINARY, sta=
ge_arg, NULL};
>       |                                                             ^~~~~=
~~~~
>
> /home/mike/git/linux/tools/testing/selftests/liveupdate/init.c:111:65: no=
te: (near initialization for =E2=80=98argv[1]=E2=80=99)
> /home/mike/git/linux/tools/testing/selftests/liveupdate/init.c:113:37: er=
ror: passing argument 2 of =E2=80=98execve=E2=80=99 from incompatible point=
er type [-Wincompatible-pointer-types]
>   113 |                 execve(TEST_BINARY, argv, NULL);
>       |                                     ^~~~
>       |                                     |
>       |                                     const char * const*
> In file included from /home/mike/git/linux/tools/testing/selftests/liveup=
date/init.c:16:
> /usr/include/unistd.h:572:52: note: expected =E2=80=98char * const*=E2=80=
=99 but argument is of type =E2=80=98const char * const*=E2=80=99
>   572 | extern int execve (const char *__path, char *const __argv[],
>       |                                        ~~~~~~~~~~~~^~~~~~~~
>
> > +
> > +     cat > "$workspace_dir/cpio_list_inner" <<EOF
> > +dir /dev 0755 0 0
> > +dir /proc 0755 0 0
> > +dir /debugfs 0755 0 0
> > +nod /dev/console 0600 0 0 c 5 1
>
> Don't you need /dev/liveupdate node?

That should be created by the kernel itself.

>
> > +file /init $workspace_dir/init 0755 0 0
> > +file /test_binary $workspace_dir/test_binary 0755 0 0
> > +EOF
> > +
> > +     # Generate inner_initrd.cpio
> > +     "$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list_inner" >=
 "$workspace_dir/inner_initrd.cpio"
> > +
> > +     cat > "$workspace_dir/cpio_list" <<EOF
> > +dir /dev 0755 0 0
> > +dir /proc 0755 0 0
> > +dir /debugfs 0755 0 0
> > +nod /dev/console 0600 0 0 c 5 1
>
> And here as well.

Not needed.

>
> > +file /init $workspace_dir/init 0755 0 0
> > +file /kernel $kernel_path 0644 0 0
> > +file /test_binary $workspace_dir/test_binary 0755 0 0
> > +file /initrd.img $workspace_dir/inner_initrd.cpio 0644 0 0
> > +EOF
> > +
> > +     # Generate the final initrd
> > +     "$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list" > "$ini=
trd"
> > +     local size=3D$(du -h "$initrd" | cut -f1)
> > +}
> > +
> > +function run_qemu() {
> > +     local qemu_cmd=3D$1
> > +     local cmdline=3D$2
> > +     local kernel_path=3D$3
> > +     local serial=3D"$workspace_dir/qemu.serial"
> > +
> > +     local accel=3D"-accel tcg"
> > +     local host_machine=3D$(uname -m)
> > +
> > +     [[ "$host_machine" =3D=3D "arm64" ]] && host_machine=3D"aarch64"
> > +     [[ "$host_machine" =3D=3D "x86_64" ]] && host_machine=3D"x86_64"
> > +
> > +     if [[ "$qemu_cmd" =3D=3D *"$host_machine"* ]]; then
> > +             if [ -w /dev/kvm ]; then
> > +                     accel=3D"-accel kvm"
>
> Just pass both kvm and tcg and let qemu complain.

I hated those warnings, this is why I added this "if" in the first place :-=
)

Thank you for your reviews, I am going to send this patch separately
from this series, so let's continue the discussion there.

Pasha

