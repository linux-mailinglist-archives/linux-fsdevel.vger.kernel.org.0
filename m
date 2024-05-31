Return-Path: <linux-fsdevel+bounces-20618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F098D6257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0CF2831DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8915886A;
	Fri, 31 May 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtVVkdkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3F158205
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160717; cv=none; b=icLlRKxSxDcdv4RnZS/ZFtNYOEDJAXaC1VQBoS6Xn5Ok+wYjOMx55+OvgdbVdCRidCeShDFSfYS/AsB8kuKm7iw2sesqFpH1OmbJj6OuuYPAYYhs7MuV9SarAlmBcxcmf3VwR2kBTTW7SNdoqcYmLwftB6kiotNJVP7dB7Fo3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160717; c=relaxed/simple;
	bh=GWbNP7Hump+oT5UlMEwynHjn6ylIFslILoxWj5BK/tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRNR4RlWfBQ/E7wMlAjGVDhjhfeNI4G+IFuZMMHrrHZoVlKIhy+DJvWQHr9QbnBRiMGQ5dLniqWixEQENO5ED4fhDWYZsrZaun9W8jiUZctwxljiB4DVlSkdolKqbzTmHB9ArGoT0a/IF2IKohUGePgrMQjKfdSJTH2Op3qeBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtVVkdkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6363C116B1;
	Fri, 31 May 2024 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717160716;
	bh=GWbNP7Hump+oT5UlMEwynHjn6ylIFslILoxWj5BK/tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtVVkdkN3gZwfDMSV+dVn1jkPO14iKGQoLitKRc18esvynYohDGN8LFDRiACFspCj
	 X0/GBOnZogj19jIPcgmO34u8b0Pf4GIzLkqehYFAvwcibwpCN2jpccDez5cnogC97E
	 7O4644oZFaZKnGrKnqSZOHH5OSv6GY31XGlnrYQlh6Au3r9COz230oylIcl4gutRF9
	 wztYbXzIarWET2kLVCKja9QQUCYWG80dexyq+wjCBJkWZ9kIWfUC9u3fAZNy1nfaFC
	 HwT6x/DUgRvELfOf4FBjeQV/uOyBj2/OR37+xw6LupJhSw+zRK9jhELYgvxjHNsnIu
	 DCKy+KXsXOzpg==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	amir73il@gmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	david@fromorbit.com,
	hch@lst.de
Subject: [PATCH] fs: don't block i_writecount during exec
Date: Fri, 31 May 2024 15:01:43 +0200
Message-ID: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=12152; i=brauner@kernel.org;  h=from:subject:message-id; bh=QFLgTpfgCRsnCYQPJar8EQsynNi+R6HyYEYeymUbQfk=;  b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRFnsrZqPc8ZoNB4oJ0NX3eetEQbePboXPt9iTf3X5a+  96nlTM/dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk3j9GhnsCn90TDvHXPL4w  6bKJvPhKjyr32brb8n59X5k74Z5XZAbDP4tOtQPJNySnxgQsPV9V863x56uQfW8WqVnvmlWvrsU  VzAoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;  fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: quoted-printable

Back in 2021 we already discussed removing deny_write_access() for=0D
executables. Back then I was hesistant because I thought that this might=0D
cause issues in userspace. But even back then I had started taking some=0D
notes on what could potentially depend on this and I didn't come up with=0D
a lot so I've changed my mind and I would like to try this.=0D
=0D
Here are some of the notes that I took:=0D
=0D
(1) The deny_write_access() mechanism is causing really pointless issues=0D
    such as [1]. If a thread in a thread-group opens a file writable,=0D
    then writes some stuff, then closing the file descriptor and then=0D
    calling execve() they can fail the execve() with ETXTBUSY because=0D
    another thread in the thread-group could have concurrently called=0D
    fork(). Multi-threaded libraries such as go suffer from this.=0D
=0D
(2) There are userspace attacks that rely on overwriting the binary of a=0D
    running process. These attacks are _mitigated_ but _not at all=0D
    prevented_ from ocurring by the deny_write_access() mechanism.=0D
=0D
    I'll go over some details. The clearest example of such attacks was=0D
    the attack against runC in CVE-2019-5736 (cf. [3]).=0D
=0D
    An attack could compromise the runC host binary from inside a=0D
    _privileged_ runC container. The malicious binary could then be used=0D
    to take over the host.=0D
=0D
    (It is crucial to note that this attack is _not_ possible with=0D
     unprivileged containers. IOW, the setup here is already insecure.)=0D
=0D
    The attack can be made when attaching to a running container or when=0D
    starting a container running a specially crafted image. For example,=0D
    when runC attaches to a container the attacker can trick it into=0D
    executing itself.=0D
=0D
    This could be done by replacing the target binary inside the=0D
    container with a custom binary pointing back at the runC binary=0D
    itself. As an example, if the target binary was /bin/bash, this=0D
    could be replaced with an executable script specifying the=0D
    interpreter path #!/proc/self/exe.=0D
=0D
    As such when /bin/bash is executed inside the container, instead the=0D
    target of /proc/self/exe will be executed. That magic link will=0D
    point to the runc binary on the host. The attacker can then proceed=0D
    to write to the target of /proc/self/exe to try and overwrite the=0D
    runC binary on the host.=0D
=0D
    However, this will not succeed because of deny_write_access(). Now,=0D
    one might think that this would prevent the attack but it doesn't.=0D
=0D
    To overcome this, the attacker has multiple ways:=0D
    * Open a file descriptor to /proc/self/exe using the O_PATH flag and=0D
      then proceed to reopen the binary as O_WRONLY through=0D
      /proc/self/fd/<nr> and try to write to it in a busy loop from a=0D
      separate process. Ultimately it will succeed when the runC binary=0D
      exits. After this the runC binary is compromised and can be used=0D
      to attack other containers or the host itself.=0D
    * Use a malicious shared library annotating a function in there with=0D
      the constructor attribute making the malicious function run as an=0D
      initializor. The malicious library will then open /proc/self/exe=0D
      for creating a new entry under /proc/self/fd/<nr>. It'll then call=0D
      exec to a) force runC to exit and b) hand the file descriptor off=0D
      to a program that then reopens /proc/self/fd/<nr> for writing=0D
      (which is now possible because runC has exited) and overwriting=0D
      that binary.=0D
=0D
    To sum up: the deny_write_access() mechanism doesn't prevent such=0D
    attacks in insecure setups. It just makes them minimally harder.=0D
    That's all.=0D
=0D
    The only way back then to prevent this is to create a temporary copy=0D
    of the calling binary itself when it starts or attaches to=0D
    containers. So what I did back then for LXC (and Aleksa for runC)=0D
    was to create an anonymous, in-memory file using the memfd_create()=0D
    system call and to copy itself into the temporary in-memory file,=0D
    which is then sealed to prevent further modifications. This sealed,=0D
    in-memory file copy is then executed instead of the original on-disk=0D
    binary.=0D
=0D
    Any compromising write operations from a privileged container to the=0D
    host binary will then write to the temporary in-memory binary and=0D
    not to the host binary on-disk, preserving the integrity of the host=0D
    binary. Also as the temporary, in-memory binary is sealed, writes to=0D
    this will also fail.=0D
=0D
    The point is that deny_write_access() is uselss to prevent these=0D
    attacks.=0D
=0D
(3) Denying write access to an inode because it's currently used in an=0D
    exec path could easily be done on an LSM level. It might need an=0D
    additional hook but that should be about it.=0D
=0D
(4) The MAP_DENYWRITE flag for mmap() has been deprecated a long time=0D
    ago so while we do protect the main executable the bigger portion of=0D
    the things you'd think need protecting such as the shared libraries=0D
    aren't. IOW, we let anyone happily overwrite shared libraries.=0D
=0D
(5) We removed all remaining uses of VM_DENYWRITE in [2]. That means:=0D
    (5.1) We removed the legacy uselib() protection for preventing=0D
          overwriting of shared libraries. Nobody cared in 3 years.=0D
    (5.2) We allow write access to the elf interpreter after exec=0D
          completed treating it on a par with shared libraries.=0D
=0D
Yes, someone in userspace could potentially be relying on this. It's not=0D
completely out of the realm of possibility but let's find out if that's=0D
actually the case and not guess.=0D
=0D
Link: https://github.com/golang/go/issues/22315 [1]=0D
Link: 49624efa65ac ("Merge tag 'denywrite-for-5.15' of git://github.com/dav=
idhildenbrand/linux") [2]=0D
Link: https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaini=
ng-cve-2019-5736 [3]=0D
Link: https://lwn.net/Articles/866493=0D
Link: https://github.com/golang/go/issues/22220=0D
Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab7=
16a97/src/cmd/go/internal/work/buildid.go#L724=0D
Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab7=
16a97/src/cmd/go/internal/work/exec.go#L1493=0D
Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab7=
16a97/src/cmd/go/internal/script/cmds.go#L457=0D
Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab7=
16a97/src/cmd/go/internal/test/test.go#L1557=0D
Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab7=
16a97/src/os/exec/lp_linux_test.go#L61=0D
Link: https://github.com/buildkite/agent/pull/2736=0D
Link: https://github.com/rust-lang/rust/issues/114554=0D
Link: https://bugs.openjdk.org/browse/JDK-8068370=0D
Link: https://github.com/dotnet/runtime/issues/58964=0D
Signed-off-by: Christian Brauner <brauner@kernel.org>=0D
---=0D
---=0D
 fs/binfmt_elf.c       |  2 --=0D
 fs/binfmt_elf_fdpic.c |  5 +----=0D
 fs/binfmt_misc.c      |  7 ++-----=0D
 fs/exec.c             | 14 +++-----------=0D
 kernel/fork.c         | 26 +++-----------------------=0D
 5 files changed, 9 insertions(+), 45 deletions(-)=0D
=0D
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c=0D
index a43897b03ce9..6fdec541f8bf 100644=0D
--- a/fs/binfmt_elf.c=0D
+++ b/fs/binfmt_elf.c=0D
@@ -1216,7 +1216,6 @@ static int load_elf_binary(struct linux_binprm *bprm)=
=0D
 		}=0D
 		reloc_func_desc =3D interp_load_addr;=0D
 =0D
-		allow_write_access(interpreter);=0D
 		fput(interpreter);=0D
 =0D
 		kfree(interp_elf_ex);=0D
@@ -1308,7 +1307,6 @@ static int load_elf_binary(struct linux_binprm *bprm)=
=0D
 	kfree(interp_elf_ex);=0D
 	kfree(interp_elf_phdata);=0D
 out_free_file:=0D
-	allow_write_access(interpreter);=0D
 	if (interpreter)=0D
 		fput(interpreter);=0D
 out_free_ph:=0D
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c=0D
index b799701454a9..28a3439f163a 100644=0D
--- a/fs/binfmt_elf_fdpic.c=0D
+++ b/fs/binfmt_elf_fdpic.c=0D
@@ -394,7 +394,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *b=
prm)=0D
 			goto error;=0D
 		}=0D
 =0D
-		allow_write_access(interpreter);=0D
 		fput(interpreter);=0D
 		interpreter =3D NULL;=0D
 	}=0D
@@ -466,10 +465,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *=
bprm)=0D
 	retval =3D 0;=0D
 =0D
 error:=0D
-	if (interpreter) {=0D
-		allow_write_access(interpreter);=0D
+	if (interpreter)=0D
 		fput(interpreter);=0D
-	}=0D
 	kfree(interpreter_name);=0D
 	kfree(exec_params.phdrs);=0D
 	kfree(exec_params.loadmap);=0D
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c=0D
index 68fa225f89e5..21ce5ec1ea76 100644=0D
--- a/fs/binfmt_misc.c=0D
+++ b/fs/binfmt_misc.c=0D
@@ -247,13 +247,10 @@ static int load_misc_binary(struct linux_binprm *bprm=
)=0D
 	if (retval < 0)=0D
 		goto ret;=0D
 =0D
-	if (fmt->flags & MISC_FMT_OPEN_FILE) {=0D
+	if (fmt->flags & MISC_FMT_OPEN_FILE)=0D
 		interp_file =3D file_clone_open(fmt->interp_file);=0D
-		if (!IS_ERR(interp_file))=0D
-			deny_write_access(interp_file);=0D
-	} else {=0D
+	else=0D
 		interp_file =3D open_exec(fmt->interpreter);=0D
-	}=0D
 	retval =3D PTR_ERR(interp_file);=0D
 	if (IS_ERR(interp_file))=0D
 		goto ret;=0D
diff --git a/fs/exec.c b/fs/exec.c=0D
index 40073142288f..4dee205452e2 100644=0D
--- a/fs/exec.c=0D
+++ b/fs/exec.c=0D
@@ -952,10 +952,6 @@ static struct file *do_open_execat(int fd, struct file=
name *name, int flags)=0D
 			 path_noexec(&file->f_path)))=0D
 		goto exit;=0D
 =0D
-	err =3D deny_write_access(file);=0D
-	if (err)=0D
-		goto exit;=0D
-=0D
 out:=0D
 	return file;=0D
 =0D
@@ -971,8 +967,7 @@ static struct file *do_open_execat(int fd, struct filen=
ame *name, int flags)=0D
  *=0D
  * Returns ERR_PTR on failure or allocated struct file on success.=0D
  *=0D
- * As this is a wrapper for the internal do_open_execat(), callers=0D
- * must call allow_write_access() before fput() on release. Also see=0D
+ * As this is a wrapper for the internal do_open_execat(). Also see=0D
  * do_close_execat().=0D
  */=0D
 struct file *open_exec(const char *name)=0D
@@ -1524,10 +1519,8 @@ static int prepare_bprm_creds(struct linux_binprm *b=
prm)=0D
 /* Matches do_open_execat() */=0D
 static void do_close_execat(struct file *file)=0D
 {=0D
-	if (!file)=0D
-		return;=0D
-	allow_write_access(file);=0D
-	fput(file);=0D
+	if (file)=0D
+		fput(file);=0D
 }=0D
 =0D
 static void free_bprm(struct linux_binprm *bprm)=0D
@@ -1846,7 +1839,6 @@ static int exec_binprm(struct linux_binprm *bprm)=0D
 		bprm->file =3D bprm->interpreter;=0D
 		bprm->interpreter =3D NULL;=0D
 =0D
-		allow_write_access(exec);=0D
 		if (unlikely(bprm->have_execfd)) {=0D
 			if (bprm->executable) {=0D
 				fput(exec);=0D
diff --git a/kernel/fork.c b/kernel/fork.c=0D
index 99076dbe27d8..763a042eef9c 100644=0D
--- a/kernel/fork.c=0D
+++ b/kernel/fork.c=0D
@@ -616,12 +616,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, stru=
ct mm_struct *oldmm)=0D
 =0D
 	exe_file =3D get_mm_exe_file(oldmm);=0D
 	RCU_INIT_POINTER(mm->exe_file, exe_file);=0D
-	/*=0D
-	 * We depend on the oldmm having properly denied write access to the=0D
-	 * exe_file already.=0D
-	 */=0D
-	if (exe_file && deny_write_access(exe_file))=0D
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);=0D
 }=0D
 =0D
 #ifdef CONFIG_MMU=0D
@@ -1412,20 +1406,11 @@ int set_mm_exe_file(struct mm_struct *mm, struct fi=
le *new_exe_file)=0D
 	 */=0D
 	old_exe_file =3D rcu_dereference_raw(mm->exe_file);=0D
 =0D
-	if (new_exe_file) {=0D
-		/*=0D
-		 * We expect the caller (i.e., sys_execve) to already denied=0D
-		 * write access, so this is unlikely to fail.=0D
-		 */=0D
-		if (unlikely(deny_write_access(new_exe_file)))=0D
-			return -EACCES;=0D
+	if (new_exe_file)=0D
 		get_file(new_exe_file);=0D
-	}=0D
 	rcu_assign_pointer(mm->exe_file, new_exe_file);=0D
-	if (old_exe_file) {=0D
-		allow_write_access(old_exe_file);=0D
+	if (old_exe_file)=0D
 		fput(old_exe_file);=0D
-	}=0D
 	return 0;=0D
 }=0D
 =0D
@@ -1464,9 +1449,6 @@ int replace_mm_exe_file(struct mm_struct *mm, struct =
file *new_exe_file)=0D
 			return ret;=0D
 	}=0D
 =0D
-	ret =3D deny_write_access(new_exe_file);=0D
-	if (ret)=0D
-		return -EACCES;=0D
 	get_file(new_exe_file);=0D
 =0D
 	/* set the new file */=0D
@@ -1475,10 +1457,8 @@ int replace_mm_exe_file(struct mm_struct *mm, struct=
 file *new_exe_file)=0D
 	rcu_assign_pointer(mm->exe_file, new_exe_file);=0D
 	mmap_write_unlock(mm);=0D
 =0D
-	if (old_exe_file) {=0D
-		allow_write_access(old_exe_file);=0D
+	if (old_exe_file)=0D
 		fput(old_exe_file);=0D
-	}=0D
 	return 0;=0D
 }=0D
 =0D
=0D
---=0D
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0=0D
change-id: 20240531-vfs-i_writecount-ee88353b2d7f=0D
=0D

