Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49285765519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjG0NdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjG0NdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:33:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8A272D;
        Thu, 27 Jul 2023 06:33:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so1708442e87.0;
        Thu, 27 Jul 2023 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690464780; x=1691069580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNVKS520fpom9zikP7GGO5Kqp+pwk56e852uQYR5BkU=;
        b=gf7mfFC/0wfbZM46ODlqyIyv7XknlmYmjPR9vw7W5BQFPqJU4Dvn9yg6veiQ6fM+pF
         nXMnhG+yw5I01J267ZuyGzRO+SBrZT5Ef7m0FLLGY9NKG0RlwXGjD+1LMmc3UAC9NNHr
         5MZ9vcBrJBzR5IPUFe8K4GI2jvTKyLZbhCpJqQ6KOhz7oMxf7TApXZhC35oHvSEKuiTV
         0JPds7aR9qmkiwwpjA8m8S8lhBB7gmQiAHH1osDN3JVV+9Wsr1PBsUnme1rLbEHHVLWh
         jf5nnPwwXx0EbPQTKmCDOaIDuQc3ep2i+cyOCkN+ou+PX1360JxiRMWouq3mX2m3+Zf9
         QyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464780; x=1691069580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNVKS520fpom9zikP7GGO5Kqp+pwk56e852uQYR5BkU=;
        b=GmWrAG0/uVonbj9ngt9PNNYcqqHMjZW33OAHl6duy5LetTIm6b2EER71cu2sgLnS4+
         P3XKj3lBEeoT2y/caVMuM9oBoOzKbLXjt5iAr8p77vKMbBpceWU1SVeQHMaYPqa8fapU
         6rDORcfDJdYZbrDWkw8jAEaYILfd9Lo6+Twwm7GMp1ua3+nBoigVn5NuttbFgzpUX7HU
         k86quOO9EhbZ5RJHIz4j89R3FS6TN95jTEWGgVxZGDyqIW6T4t2cFuY6S+Zish+Ss9Db
         jDIU4UYjCVBBW8Ke73fLPCXEOk1qgYbSaOaYI2xbpgbh+/17JCwvgV0RzPvUIdsrCdOn
         5yjA==
X-Gm-Message-State: ABy/qLbPFAgT0HPkjbdqIYU0Ng7Kx99byc7KSl2qmbLG4QwShLWE7QKU
        721ryxot7/NSDgkWRN77tqwxd1AjtKr7J5/VmCs=
X-Google-Smtp-Source: APBJJlEoaBon0qIf+o3H5ybsdyY2J571wEx/HePSoiAhvwnMkjCJxjZ1SwZXzaOy8H1h8XAtUs9aG/a95vBooddqtpQ=
X-Received: by 2002:a2e:b015:0:b0:2b6:d326:156d with SMTP id
 y21-20020a2eb015000000b002b6d326156dmr1776436ljk.19.1690464779581; Thu, 27
 Jul 2023 06:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-7-amiculas@cisco.com>
In-Reply-To: <20230726164535.230515-7-amiculas@cisco.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 27 Jul 2023 16:32:48 +0300
Message-ID: <CAPDJoNs_VTnVATXr4AFs5D8unOihrpYXLDn69fjT0OshrYADXA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] rust: file: pass the filesystem context to
 the open function
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.pizza,
        brauner@kernel.org, viro@zeniv.linux.org.uk, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 7:58=E2=80=AFPM Ariel Miculas <amiculas@cisco.com> =
wrote:
>
> This allows us to create a Vfsmount structure and pass it to the read
> callback.
>
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> ---
>  rust/kernel/file.rs      | 17 +++++++++++++++--
>  samples/rust/puzzlefs.rs | 40 +++++++++++++++++++++++++++++++++++-----
>  samples/rust/rust_fs.rs  |  3 ++-
>  3 files changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index a3002c416dbb..af1eb1ee9267 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -457,9 +457,15 @@ impl<A: OpenAdapter<T::OpenData>, T: Operations> Ope=
rationsVtable<A, T> {
>              // `fileref` never outlives this function, so it is guarante=
ed to be
>              // valid.
>              let fileref =3D unsafe { File::from_ptr(file) };
> +
> +            // SAFETY: into_foreign was called in fs::NewSuperBlock<...,=
 NeedsInit>::init and
> +            // it is valid until from_foreign will be called in fs::Tabl=
es::free_callback
> +            let fs_info =3D
> +                unsafe { <T::Filesystem as fs::Type>::Data::borrow((*(*i=
node).i_sb).s_fs_info) };
> +
>              // SAFETY: `arg` was previously returned by `A::convert` and=
 must
>              // be a valid non-null pointer.
> -            let ptr =3D T::open(unsafe { &*arg }, fileref)?.into_foreign=
();
> +            let ptr =3D T::open(fs_info, unsafe { &*arg }, fileref)?.int=
o_foreign();
>              // SAFETY: The C contract guarantees that `private_data` is =
available
>              // for implementers of the file operations (no other C code =
accesses
>              // it), so we know that there are no concurrent threads/CPUs=
 accessing
> @@ -930,10 +936,17 @@ pub trait Operations {
>      /// The type of the context data passed to [`Operations::open`].
>      type OpenData: Sync =3D ();
>
> +    /// Data associated with each file system instance.
> +    type Filesystem: fs::Type;
> +
>      /// Creates a new instance of this file.
>      ///
>      /// Corresponds to the `open` function pointer in `struct file_opera=
tions`.
> -    fn open(context: &Self::OpenData, file: &File) -> Result<Self::Data>=
;
> +    fn open(
> +        fs_info: <<Self::Filesystem as fs::Type>::Data as ForeignOwnable=
>::Borrowed<'_>,
> +        context: &Self::OpenData,
> +        file: &File,
> +    ) -> Result<Self::Data>;
>
>      /// Cleans up after the last reference to the file goes away.
>      ///
> diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
> index 9afd82745b64..8a64e0bd437d 100644
> --- a/samples/rust/puzzlefs.rs
> +++ b/samples/rust/puzzlefs.rs
> @@ -3,8 +3,14 @@
>  //! Rust file system sample.
>
>  use kernel::module_fs;
> +use kernel::mount::Vfsmount;
>  use kernel::prelude::*;
> -use kernel::{c_str, file, fs, io_buffer::IoBufferWriter};
> +use kernel::{
> +    c_str, file, fmt, fs,
> +    io_buffer::IoBufferWriter,
> +    str::CString,
> +    sync::{Arc, ArcBorrow},
> +};
>
>  mod puzzle;
>  // Required by the autogenerated '_capnp.rs' files
> @@ -19,6 +25,12 @@
>
>  struct PuzzleFsModule;
>
> +#[derive(Debug)]
> +struct PuzzlefsInfo {
> +    base_path: CString,
> +    vfs_mount: Arc<Vfsmount>,
> +}
> +
>  #[vtable]
>  impl fs::Context<Self> for PuzzleFsModule {
>      type Data =3D ();
> @@ -46,14 +58,23 @@ fn try_new() -> Result {
>  impl fs::Type for PuzzleFsModule {
>      type Context =3D Self;
>      type INodeData =3D &'static [u8];
> +    type Data =3D Box<PuzzlefsInfo>;
>      const SUPER_TYPE: fs::Super =3D fs::Super::Independent;
>      const NAME: &'static CStr =3D c_str!("puzzlefs");
>      const FLAGS: i32 =3D fs::flags::USERNS_MOUNT;
>      const DCACHE_BASED: bool =3D true;
>
>      fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<=
&fs::SuperBlock<Self>> {
> +        let base_path =3D CString::try_from_fmt(fmt!("hello world"))?;
> +        pr_info!("base_path {:?}\n", base_path);
> +        let vfs_mount =3D Vfsmount::new_private_mount(c_str!("/home/puzz=
lefs_oci"))?;
> +        pr_info!("vfs_mount {:?}\n", vfs_mount);
> +
>          let sb =3D sb.init(
> -            (),
> +            Box::try_new(PuzzlefsInfo {
> +                base_path,
> +                vfs_mount: Arc::try_new(vfs_mount)?,
> +            })?,
>              &fs::SuperParams {
>                  magic: 0x72757374,
>                  ..fs::SuperParams::DEFAULT
> @@ -88,14 +109,23 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, S=
elf>) -> Result<&fs::SuperBl
>
>  #[vtable]
>  impl file::Operations for FsFile {
> +    // must be the same as INodeData
>      type OpenData =3D &'static [u8];
> +    type Filesystem =3D PuzzleFsModule;
> +    // this is an Arc because Data must be ForeignOwnable and the only i=
mplementors of it are Box,
> +    // Arc and (); we cannot pass a reference to read, so we share Vfsmo=
unt using and Arc
> +    type Data =3D Arc<Vfsmount>;
>
> -    fn open(_context: &Self::OpenData, _file: &file::File) -> Result<Sel=
f::Data> {
> -        Ok(())
> +    fn open(
> +        fs_info: &PuzzlefsInfo,
> +        _context: &Self::OpenData,
> +        _file: &file::File,
> +    ) -> Result<Self::Data> {
> +        Ok(fs_info.vfs_mount.clone())
>      }
>
>      fn read(
> -        _data: (),
> +        data: ArcBorrow<'_, Vfsmount>,
>          file: &file::File,
>          writer: &mut impl IoBufferWriter,
>          offset: u64,
> diff --git a/samples/rust/rust_fs.rs b/samples/rust/rust_fs.rs
> index 7527681ee024..c58ed1560e06 100644
> --- a/samples/rust/rust_fs.rs
> +++ b/samples/rust/rust_fs.rs
> @@ -85,8 +85,9 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self=
>) -> Result<&fs::SuperBl
>  #[vtable]
>  impl file::Operations for FsFile {
>      type OpenData =3D &'static [u8];
> +    type Filesystem =3D RustFs;
>
> -    fn open(_context: &Self::OpenData, _file: &file::File) -> Result<Sel=
f::Data> {
> +    fn open(_fs_info: (), _context: &Self::OpenData, _file: &file::File)=
 -> Result<Self::Data> {
>          Ok(())
>      }
>
> --
> 2.41.0
>
>
Hey Wedson,

Is it ok to couple file::Operations with fs::Type? I didn't find a
better way to implement this.
I'm asking because I've seen you've gone to great lengths to decouple them.

Cheers,
Ariel
