Return-Path: <linux-fsdevel+bounces-69390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B926FC7B0FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2053A282E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B82F0C6E;
	Fri, 21 Nov 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqvjpH15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D92836F;
	Fri, 21 Nov 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745890; cv=none; b=GVDDLfNrXSX9cmPo0X7RTkUu0nO/+ZjEzslZjz0dizulrIUDLVQkB+T7Pes0zxcUEaNjPMDSC6EGyqG6cfbDRTZv4sg9mnqEJlgJyaiMr0n4jm0Lykx4qzl6SMF+csLTH1LqGAJEd16DepD4ogwILUDYv5VRP6twpL+wfzbYnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745890; c=relaxed/simple;
	bh=iLWWijEcNLY22PnrPHaN8TmaoBcSCk/mzyMLvRR5Lpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZGO2QU++1UujV4E6g4OnIKuJmBvDhrwd8iBzujuVr7igdEnx5gsk/Lk1ws0Wq7IMj0EstlkiwhFkysbpEo2ySsdGlmjlac1Wd5DFlHn7QXRY2aBKE9jDi5PmFNTXatGnSthLLisj/lurFZxGZK+9Smj+Ic7oxVY/6p78Ym2bnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqvjpH15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DEC116C6;
	Fri, 21 Nov 2025 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745889;
	bh=iLWWijEcNLY22PnrPHaN8TmaoBcSCk/mzyMLvRR5Lpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NqvjpH15rDvRPADzp9cQpVvPzPZMUwntgy4CLucIHzmAAoaFAa1O9t64x0fc32+GO
	 Rk1Joc6dEWzo8vC2U7X4HBDzUd4tsjQkJezsCwcFwjxLkNBLg0whG0bHASBfM3cAI+
	 Y7OM1tCbB+z0Gjj2NGR+rd7dw4c8evj+NHsfr0zAW3Sse8ShLDBMUvK6HoGNoNr5te
	 sK4pT7zrPkKutrscPoFBX0zV3URxm3TId6RqnYHfyPTZcSG/kV2VTrd5trgHLgulEe
	 3sid5yQ/ObfU1dd9T+i1+vTVZTjmVe6pHzXKmbL99FUcIeiWM69z1GdRtnL1U3+PNM
	 yw6pE7S0Y7axw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
In-Reply-To: <20251115233409.768044-7-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 15 Nov 2025 18:33:52 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-7-pasha.tatashin@soleen.com>
Date: Fri, 21 Nov 2025 18:24:38 +0100
Message-ID: <mafs0wm3jz4bt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15 2025, Pasha Tatashin wrote:

> This patch implements the core mechanism for managing preserved
> files throughout the live update lifecycle. It provides the logic to
> invoke the file handler callbacks (preserve, unpreserve, freeze,
> unfreeze, retrieve, and finish) at the appropriate stages.
>
> During the reboot phase, luo_file_freeze() serializes the final
> metadata for each file (handler compatible string, token, and data
> handle) into a memory region preserved by KHO. In the new kernel,
> luo_file_deserialize() reconstructs the in-memory file list from this
> data, preparing the session for retrieval.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> +
> +static LIST_HEAD(luo_file_handler_list);
> +
> +/* 2 4K pages, give space for 128 files per session */
> +#define LUO_FILE_PGCNT		2ul
> +#define LUO_FILE_MAX							\
> +	((LUO_FILE_PGCNT << PAGE_SHIFT) / sizeof(struct luo_file_ser))
> +
> +/**
> + * struct luo_file - Represents a single preserved file instance.
> + * @fh:            Pointer to the &struct liveupdate_file_handler that m=
anages
> + *                 this type of file.
> + * @file:          Pointer to the kernel's &struct file that is being pr=
eserved.
> + *                 This is NULL in the new kernel until the file is succ=
essfully
> + *                 retrieved.
> + * @serialized_data: The opaque u64 handle to the serialized state of th=
e file.
> + *                 This handle is passed back to the handler's .freeze(),
> + *                 .retrieve(), and .finish() callbacks, allowing it to =
track
> + *                 and update its serialized state across phases.
> + * @retrieved:     A flag indicating whether a user/kernel in the new ke=
rnel has
> + *                 successfully called retrieve() on this file. This pre=
vents
> + *                 multiple retrieval attempts.
> + * @mutex:         A mutex that protects the fields of this specific ins=
tance
> + *                 (e.g., @retrieved, @file), ensuring that operations l=
ike
> + *                 retrieving or finishing a file are atomic.
> + * @list:          The list_head linking this instance into its parent
> + *                 session's list of preserved files.
> + * @token:         The user-provided unique token used to identify this =
file.
> + *
> + * This structure is the core in-kernel representation of a single file =
being
> + * managed through a live update. An instance is created by luo_preserve=
_file()
> + * to link a 'struct file' to its corresponding handler, a user-provided=
 token,
> + * and the serialized state handle returned by the handler's .preserve()
> + * operation.
> + *
> + * These instances are tracked in a per-session list. The @serialized_da=
ta
> + * field, which holds a handle to the file's serialized state, may be up=
dated
> + * during the .freeze() callback before being serialized for the next ke=
rnel.
> + * After reboot, these structures are recreated by luo_file_deserialize(=
) and
> + * are finally cleaned up by luo_file_finish().
> + */
> +struct luo_file {
> +	struct liveupdate_file_handler *fh;
> +	struct file *file;
> +	u64 serialized_data;
> +	bool retrieved;
> +	struct mutex mutex;
> +	struct list_head list;
> +	u64 token;
> +};
> +
> +static int luo_session_alloc_files_mem(struct luo_session *session)
> +{
> +	size_t size;
> +	void *mem;
> +
> +	if (session->files)
> +		return 0;
> +
> +	WARN_ON_ONCE(session->count);
> +
> +	size =3D LUO_FILE_PGCNT << PAGE_SHIFT;
> +	mem =3D kho_alloc_preserve(size);
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
> +
> +	session->files =3D mem;
> +	session->pgcnt =3D LUO_FILE_PGCNT;

I think this is a layering violation. luo_session should take care of
managing the session, including the memory it needs. luo_files should
take care of managing the file, including the memory it needs for _the
file_. I think proper layering will make the code a lot easier to grok
and modify later. When I want to see how sessions are handled, I can do
to luo_session.c. I won't have to poke into luo_files.c.

So I think luo_session_preserve_fd() should first make sure there is
memory available to store the file in the session, and only then call
luo_preserve_file().

> +
> +	return 0;
> +}
> +
> +static void luo_session_free_files_mem(struct luo_session *session)
> +{
> +	/* If session has files, no need to free preservation memory */
> +	if (session->count)
> +		return;
> +
> +	if (!session->files)
> +		return;
> +
> +	kho_unpreserve_free(session->files);
> +	session->files =3D NULL;
> +	session->pgcnt =3D 0;
> +}
> +
> +static bool luo_token_is_used(struct luo_session *session, u64 token)
> +{
> +	struct luo_file *iter;
> +
> +	list_for_each_entry(iter, &session->files_list, list) {
> +		if (iter->token =3D=3D token)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * luo_preserve_file - Initiate the preservation of a file descriptor.
> + * @session: The session to which the preserved file will be added.
> + * @token:   A unique, user-provided identifier for the file.
> + * @fd:      The file descriptor to be preserved.
> + *
> + * This function orchestrates the first phase of preserving a file. Upon=
 entry,
> + * it takes a reference to the 'struct file' via fget(), effectively mak=
ing LUO
> + * a co-owner of the file. This reference is held until the file is eith=
er
> + * unpreserved or successfully finished in the next kernel, preventing t=
he file
> + * from being prematurely destroyed.
> + *
> + * This function orchestrates the first phase of preserving a file. It p=
erforms
> + * the following steps:
> + *
> + * 1. Validates that the @token is not already in use within the session.
> + * 2. Ensures the session's memory for files serialization is allocated
> + *    (allocates if needed).
> + * 3. Iterates through registered handlers, calling can_preserve() to fi=
nd one
> + *    compatible with the given @fd.
> + * 4. Calls the handler's .preserve() operation, which saves the file's =
state
> + *    and returns an opaque private data handle.
> + * 5. Adds the new instance to the session's internal list.
> + *
> + * On success, LUO takes a reference to the 'struct file' and considers =
it
> + * under its management until it is unpreserved or finished.
> + *
> + * In case of any failure, all intermediate allocations (file reference,=
 memory
> + * for the 'luo_file' struct, etc.) are cleaned up before returning an e=
rror.
> + *
> + * Context: Can be called from an ioctl handler during normal system ope=
ration.
> + * Return: 0 on success. Returns a negative errno on failure:
> + *         -EEXIST if the token is already used.
> + *         -EBADF if the file descriptor is invalid.
> + *         -ENOSPC if the session is full.
> + *         -ENOENT if no compatible handler is found.
> + *         -ENOMEM on memory allocation failure.
> + *         Other erros might be returned by .preserve().
> + */
> +int luo_preserve_file(struct luo_session *session, u64 token, int fd)
> +{
> +	struct liveupdate_file_op_args args =3D {0};
> +	struct liveupdate_file_handler *fh;
> +	struct luo_file *luo_file;
> +	struct file *file;
> +	int err;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (luo_token_is_used(session, token))
> +		return -EEXIST;
> +
> +	file =3D fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	err =3D luo_session_alloc_files_mem(session);
> +	if (err)
> +		goto  exit_err;
> +
> +	if (session->count =3D=3D LUO_FILE_MAX) {
> +		err =3D -ENOSPC;
> +		goto exit_err;
> +	}

Similarly, luo_file has no business knowing the size of a session.
Checking session->count should also be done in
luo_session_preserve_fd(). luo_preserve_file() should never be called if
there is no space _in the session_ to accommodate the file.

> +
> +	err =3D -ENOENT;
> +	list_for_each_entry(fh, &luo_file_handler_list, list) {
> +		if (fh->ops->can_preserve(fh, file)) {
> +			err =3D 0;
> +			break;
> +		}
> +	}
> +
> +	/* err is still -ENOENT if no handler was found */
> +	if (err)
> +		goto exit_err;
> +
> +	luo_file =3D kzalloc(sizeof(*luo_file), GFP_KERNEL);
> +	if (!luo_file) {
> +		err =3D -ENOMEM;
> +		goto exit_err;
> +	}
> +
> +	luo_file->file =3D file;
> +	luo_file->fh =3D fh;
> +	luo_file->token =3D token;
> +	luo_file->retrieved =3D false;
> +	mutex_init(&luo_file->mutex);
> +
> +	args.handler =3D fh;
> +	args.session =3D (struct liveupdate_session *)session;
> +	args.file =3D file;
> +	err =3D fh->ops->preserve(&args);
> +	if (err) {
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +		goto exit_err;
> +	} else {
> +		luo_file->serialized_data =3D args.serialized_data;
> +		list_add_tail(&luo_file->list, &session->files_list);
> +		session->count++;
> +	}
> +
> +	return 0;
> +
> +exit_err:
> +	fput(file);
> +	luo_session_free_files_mem(session);
> +
> +	return err;
> +}
> +
> +/**
> + * luo_file_unpreserve_files - Unpreserves all files from a session.
> + * @session: The session to be cleaned up.
> + *
> + * This function serves as the primary cleanup path for a session. It is
> + * invoked when the userspace agent closes the session's file descriptor.
> + *
> + * For each file, it performs the following cleanup actions:
> + *   1. Calls the handler's .unpreserve() callback to allow the handler =
to
> + *      release any resources it allocated.
> + *   2. Removes the file from the session's internal tracking list.
> + *   3. Releases the reference to the 'struct file' that was taken by
> + *      luo_preserve_file() via fput(), returning ownership.
> + *   4. Frees the memory associated with the internal 'struct luo_file'.
> + *
> + * After all individual files are unpreserved, it frees the contiguous m=
emory
> + * block that was allocated to hold their serialization data.
> + */
> +void luo_file_unpreserve_files(struct luo_session *session)
> +{
> +	struct luo_file *luo_file;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	while (!list_empty(&session->files_list)) {

Continuing with the layering thing, the list belongs to the session, so
it should traverse it. luo_session_release() should traverse the list
and call luo_file_unpreserve() on each file in the list. The body of
this loop becomes luo_file_unpreserve().

> +		struct liveupdate_file_op_args args =3D {0};
> +
> +		luo_file =3D list_last_entry(&session->files_list,
> +					   struct luo_file, list);
> +
> +		args.handler =3D luo_file->fh;
> +		args.session =3D (struct liveupdate_session *)session;
> +		args.file =3D luo_file->file;
> +		args.serialized_data =3D luo_file->serialized_data;
> +		luo_file->fh->ops->unpreserve(&args);
> +
> +		list_del(&luo_file->list);
> +		session->count--;

... and these two go into luo_session_release().

> +
> +		fput(luo_file->file);
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +
> +	luo_session_free_files_mem(session);
> +}
> +
> +static int luo_file_freeze_one(struct luo_session *session,
> +			       struct luo_file *luo_file)
> +{
> +	int err =3D 0;
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->freeze) {

Nit: "if (!luo_file->fh->ops->freeze) return 0;" would make this tad bit
neater. You probably don't even need the mutex since ops are const.

> +		struct liveupdate_file_op_args args =3D {0};
> +
> +		args.handler =3D luo_file->fh;
> +		args.session =3D (struct liveupdate_session *)session;
> +		args.file =3D luo_file->file;
> +		args.serialized_data =3D luo_file->serialized_data;
> +
> +		err =3D luo_file->fh->ops->freeze(&args);
> +		if (!err)
> +			luo_file->serialized_data =3D args.serialized_data;

Then this can be:

	if (err)
		return err;

	luo_file->serialized_data =3D args.serialized_data;
	return 0;

> +	}
> +
> +	return err;
> +}
> +
> +static void luo_file_unfreeze_one(struct luo_session *session,
> +				  struct luo_file *luo_file)
> +{
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->unfreeze) {

Same here.

> +		struct liveupdate_file_op_args args =3D {0};
> +
> +		args.handler =3D luo_file->fh;
> +		args.session =3D (struct liveupdate_session *)session;
> +		args.file =3D luo_file->file;
> +		args.serialized_data =3D luo_file->serialized_data;
> +
> +		luo_file->fh->ops->unfreeze(&args);
> +	}
> +
> +	luo_file->serialized_data =3D 0;

The file will also need to be unpreserved after unfreeze. Resetting the
data here is not the right thing, since unpreserve is responsible for
freeing things, and it won't have access to its data.

> +}
> +
> +static void __luo_file_unfreeze(struct luo_session *session,
> +				struct luo_file *failed_entry)
> +{
> +	struct list_head *files_list =3D &session->files_list;
> +	struct luo_file *luo_file;
> +
> +	list_for_each_entry(luo_file, files_list, list) {
> +		if (luo_file =3D=3D failed_entry)
> +			break;
> +
> +		luo_file_unfreeze_one(session, luo_file);
> +	}
> +
> +	memset(session->files, 0, session->pgcnt << PAGE_SHIFT);
> +}
> +
> +/**
> + * luo_file_freeze - Freezes all preserved files and serializes their me=
tadata.
> + * @session: The session whose files are to be frozen.
> + *
> + * This function is called from the reboot() syscall path, just before t=
he
> + * kernel transitions to the new image via kexec. Its purpose is to perf=
orm the
> + * final preparation and serialization of all preserved files in the ses=
sion.
> + *
> + * It iterates through each preserved file in FIFO order (the order of
> + * preservation) and performs two main actions:
> + *
> + * 1. Freezes the File: It calls the handler's .freeze() callback for ea=
ch
> + *    file. This gives the handler a final opportunity to quiesce the de=
vice or
> + *    prepare its state for the upcoming reboot. The handler may update =
its
> + *    private data handle during this step.
> + *
> + * 2. Serializes Metadata: After a successful freeze, it copies the fina=
l file
> + *    metadata=E2=80=94the handler's compatible string, the user token, =
and the final
> + *    private data handle=E2=80=94into the pre-allocated contiguous memo=
ry buffer
> + *    (session->files) that will be handed over to the next kernel via K=
HO.
> + *
> + * Error Handling (Rollback):
> + * This function is atomic. If any handler's .freeze() operation fails, =
the
> + * entire live update is aborted. The __luo_file_unfreeze() helper is
> + * immediately called to invoke the .unfreeze() op on all files that were
> + * successfully frozen before the point of failure, rolling them back to=
 a
> + * running state. The function then returns an error, causing the reboot=
()
> + * syscall to fail.
> + *
> + * Context: Called only from the liveupdate_reboot() path.
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int luo_file_freeze(struct luo_session *session)
> +{
> +	struct luo_file_ser *file_ser =3D session->files;
> +	struct luo_file *luo_file;
> +	int err;
> +	int i;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->count)
> +		return 0;

Same comment about layering here...

> +
> +	if (WARN_ON(!file_ser))
> +		return -EINVAL;
> +
> +	i =3D 0;
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		err =3D luo_file_freeze_one(session, luo_file);
> +		if (err < 0) {
> +			pr_warn("Freeze failed for session[%s] token[%#0llx] handler[%s] err[=
%pe]\n",
> +				session->name, luo_file->token,
> +				luo_file->fh->compatible, ERR_PTR(err));
> +			goto exit_err;
> +		}
> +
> +		strscpy(file_ser[i].compatible, luo_file->fh->compatible,
> +			sizeof(file_ser[i].compatible));
> +		file_ser[i].data =3D luo_file->serialized_data;
> +		file_ser[i].token =3D luo_file->token;
> +		i++;
> +	}
> +
> +	return 0;
> +
> +exit_err:
> +	__luo_file_unfreeze(session, luo_file);
> +
> +	return err;
> +}
> +
> +/**
> + * luo_file_unfreeze - Unfreezes all files in a session.
> + * @session: The session whose files are to be unfrozen.
> + *
> + * This function rolls back the state of all files in a session after th=
e freeze
> + * phase has begun but must be aborted. It is the counterpart to
> + * luo_file_freeze().
> + *
> + * It invokes the __luo_file_unfreeze() helper with a NULL argument, whi=
ch
> + * signals the helper to iterate through all files in the session  and c=
all
> + * their respective .unfreeze() handler callbacks.
> + *
> + * Context: This is called when the live update is aborted during
> + *          the reboot() syscall, after luo_file_freeze() has been calle=
d.
> + */
> +void luo_file_unfreeze(struct luo_session *session)
> +{
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->count)
> +		return;

... and here.

> +
> +	__luo_file_unfreeze(session, NULL);
> +}
> +
> +/**
> + * luo_retrieve_file - Restores a preserved file from a session by its t=
oken.
> + * @session: The session from which to retrieve the file.
> + * @token:   The unique token identifying the file to be restored.
> + * @filep:   Output parameter; on success, this is populated with a poin=
ter
> + *           to the newly retrieved 'struct file'.
> + *
> + * This function is the primary mechanism for recreating a file in the n=
ew
> + * kernel after a live update. It searches the session's list of deseria=
lized
> + * files for an entry matching the provided @token.
> + *
> + * The operation is idempotent: if a file has already been successfully
> + * retrieved, this function will simply return a pointer to the existing
> + * 'struct file' and report success without re-executing the retrieve
> + * operation. This is handled by checking the 'retrieved' flag under a l=
ock.
> + *
> + * File retrieval can happen in any order; it is not bound by the order =
of
> + * preservation.
> + *
> + * Context: Can be called from an ioctl or other in-kernel code in the n=
ew
> + *          kernel.
> + * Return: 0 on success. Returns a negative errno on failure:
> + *         -ENOENT if no file with the matching token is found.
> + *         Any error code returned by the handler's .retrieve() op.
> + */
> +int luo_retrieve_file(struct luo_session *session, u64 token,
> +		      struct file **filep)
> +{
> +	struct liveupdate_file_op_args args =3D {0};
> +	struct luo_file *luo_file;
> +	int err;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (list_empty(&session->files_list))
> +		return -ENOENT;

... and here.

> +
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		if (luo_file->token =3D=3D token)
> +			break;
> +	}
> +
> +	if (luo_file->token !=3D token)
> +		return -ENOENT;
> +
> +	guard(mutex)(&luo_file->mutex);
> +	if (luo_file->retrieved) {
> +		/*
> +		 * Someone is asking for this file again, so get a reference
> +		 * for them.
> +		 */

Should we even allow this? Is there a use case?

> +		get_file(luo_file->file);
> +		*filep =3D luo_file->file;
> +		return 0;
> +	}
> +
> +	args.handler =3D luo_file->fh;
> +	args.session =3D (struct liveupdate_session *)session;
> +	args.serialized_data =3D luo_file->serialized_data;
> +	err =3D luo_file->fh->ops->retrieve(&args);
> +	if (!err) {
> +		luo_file->file =3D args.file;
> +
> +		/* Get reference so we can keep this file in LUO until finish */
> +		get_file(luo_file->file);
> +		*filep =3D luo_file->file;
> +		luo_file->retrieved =3D true;
> +	}
> +
> +	return err;
> +}
> +
> +static int luo_file_can_finish_one(struct luo_session *session,
> +				   struct luo_file *luo_file)
> +{
> +	bool can_finish =3D true;
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->can_finish) {

Same nitpick about doing "if (!luo_file->fh->ops->can_finish)".

> +		struct liveupdate_file_op_args args =3D {0};
> +
> +		args.handler =3D luo_file->fh;
> +		args.session =3D (struct liveupdate_session *)session;
> +		args.file =3D luo_file->file;
> +		args.serialized_data =3D luo_file->serialized_data;
> +		args.retrieved =3D luo_file->retrieved;
> +		can_finish =3D luo_file->fh->ops->can_finish(&args);
> +	}
> +
> +	return can_finish ? 0 : -EBUSY;
> +}
> +
> +static void luo_file_finish_one(struct luo_session *session,
> +				struct luo_file *luo_file)
> +{
> +	struct liveupdate_file_op_args args =3D {0};
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	args.handler =3D luo_file->fh;
> +	args.session =3D (struct liveupdate_session *)session;
> +	args.file =3D luo_file->file;
> +	args.serialized_data =3D luo_file->serialized_data;
> +	args.retrieved =3D luo_file->retrieved;
> +
> +	luo_file->fh->ops->finish(&args);
> +}
> +
> +/**
> + * luo_file_finish - Completes the lifecycle for all files in a session.
> + * @session: The session to be finalized.
> + *
> + * This function orchestrates the final teardown of a live update sessio=
n in the
> + * new kernel. It should be called after all necessary files have been
> + * retrieved and the userspace agent is ready to release the preserved s=
tate.
> + *
> + * The function iterates through all tracked files. For each file, it pe=
rforms
> + * the following sequence of cleanup actions:
> + *
> + * 1. If file is not yet retrieved, retrieves it, and calls can_finish()=
 on
> + *    every file in the session. If all can_finish return true, continue=
 to
> + *    finish.
> + * 2. Calls the handler's .finish() callback (via luo_file_finish_one) to
> + *    allow for final resource cleanup within the handler.
> + * 3. Releases LUO's ownership reference on the 'struct file' via fput()=
. This
> + *    is the counterpart to the get_file() call in luo_retrieve_file().
> + * 4. Removes the 'struct luo_file' from the session's internal list.
> + * 5. Frees the memory for the 'struct luo_file' instance itself.
> + *
> + * After successfully finishing all individual files, it frees the
> + * contiguous memory block that was used to transfer the serialized meta=
data
> + * from the previous kernel.
> + *
> + * Error Handling (Atomic Failure):
> + * This operation is atomic. If any handler's .can_finish() op fails, th=
e entire
> + * function aborts immediately and returns an error.
> + *
> + * Context: Can be called from an ioctl handler in the new kernel.
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int luo_file_finish(struct luo_session *session)
> +{
> +	struct list_head *files_list =3D &session->files_list;
> +	struct luo_file *luo_file;
> +	int err;
> +
> +	if (!session->count)
> +		return 0;

Layering comment again.

> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	list_for_each_entry(luo_file, files_list, list) {
> +		err =3D luo_file_can_finish_one(session, luo_file);
> +		if (err)
> +			return err;
> +	}
> +
> +	while (!list_empty(&session->files_list)) {
> +		luo_file =3D list_last_entry(&session->files_list,
> +					   struct luo_file, list);
> +
> +		luo_file_finish_one(session, luo_file);
> +
> +		if (luo_file->file)
> +			fput(luo_file->file);
> +		list_del(&luo_file->list);
> +		session->count--;
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +
> +	if (session->files) {
> +		kho_restore_free(session->files);
> +		session->files =3D NULL;
> +		session->pgcnt =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * luo_file_deserialize - Reconstructs the list of preserved files in th=
e new kernel.
> + * @session: The incoming session containing the serialized file data fr=
om KHO.
> + *
> + * This function is called during the early boot process of the new kern=
el. It
> + * takes the raw, contiguous memory block of 'struct luo_file_ser' entri=
es,
> + * provided by the previous kernel, and transforms it back into a live,
> + * in-memory linked list of 'struct luo_file' instances.
> + *
> + * For each serialized entry, it performs the following steps:
> + *   1. Reads the 'compatible' string.
> + *   2. Searches the global list of registered file handlers for one that
> + *      matches the compatible string.
> + *   3. Allocates a new 'struct luo_file'.
> + *   4. Populates the new structure with the deserialized data (token, p=
rivate
> + *      data handle) and links it to the found handler. The 'file' point=
er is
> + *      initialized to NULL, as the file has not been retrieved yet.
> + *   5. Adds the new 'struct luo_file' to the session's files_list.
> + *
> + * This prepares the session for userspace, which can later call
> + * luo_retrieve_file() to restore the actual file descriptors.
> + *
> + * Context: Called from session deserialization.
> + */
> +int luo_file_deserialize(struct luo_session *session)
> +{
> +	struct luo_file_ser *file_ser;
> +	u64 i;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->files)
> +		return 0;

Layering again.

> +
> +	file_ser =3D session->files;
> +	for (i =3D 0; i < session->count; i++) {
> +		struct liveupdate_file_handler *fh;
> +		bool handler_found =3D false;
> +		struct luo_file *luo_file;
> +
> +		list_for_each_entry(fh, &luo_file_handler_list, list) {
> +			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
> +				handler_found =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (!handler_found) {
> +			pr_warn("No registered handler for compatible '%s'\n",
> +				file_ser[i].compatible);
> +			return -ENOENT;
> +		}
> +
> +		luo_file =3D kzalloc(sizeof(*luo_file), GFP_KERNEL);
> +		if (!luo_file)
> +			return -ENOMEM;
> +
> +		luo_file->fh =3D fh;
> +		luo_file->file =3D NULL;
> +		luo_file->serialized_data =3D file_ser[i].data;
> +		luo_file->token =3D file_ser[i].token;
> +		luo_file->retrieved =3D false;
> +		mutex_init(&luo_file->mutex);
> +		list_add_tail(&luo_file->list, &session->files_list);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_register_file_handler - Register a file handler with LUO.
> + * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
> + * The caller must initialize this structure, including a unique
> + * 'compatible' string and a valid 'fh' callbacks. This function adds the
> + * handler to the global list of supported file handlers.
> + *
> + * Context: Typically called during module initialization for file types=
 that
> + * support live update preservation.
> + *
> + * Return: 0 on success. Negative errno on failure.
> + */
> +int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> +{
> +	static DEFINE_MUTEX(register_file_handler_lock);
> +	struct liveupdate_file_handler *fh_iter;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Once sessions have been deserialized, file handlers cannot be
> +	 * registered, it is too late.
> +	 */
> +	if (WARN_ON(luo_session_is_deserialized()))
> +		return -EBUSY;
> +
> +	/* Sanity check that all required callbacks are set */
> +	if (!fh->ops->preserve || !fh->ops->unpreserve ||
> +	    !fh->ops->retrieve || !fh->ops->finish) {

Should check can_preserve here, right?

> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&register_file_handler_lock);
> +	list_for_each_entry(fh_iter, &luo_file_handler_list, list) {
> +		if (!strcmp(fh_iter->compatible, fh->compatible)) {
> +			pr_err("File handler registration failed: Compatible string '%s' alre=
ady registered.\n",
> +			       fh->compatible);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	if (!try_module_get(fh->ops->owner))
> +		return -EAGAIN;
> +
> +	INIT_LIST_HEAD(&fh->list);
> +	list_add_tail(&fh->list, &luo_file_handler_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> + * @s:      The outgoing liveupdate session.
> + * @file:   The file object to search for.
> + * @tokenp: Output parameter for the found token.
> + *
> + * Searches the list of preserved files in an outgoing session for a mat=
ching
> + * file object. If found, the corresponding user-provided token is retur=
ned.
> + *
> + * This function is intended for in-kernel callers that need to correlat=
e a
> + * file with its liveupdate token.
> + *
> + * Context: Can be called from any context that can acquire the session =
mutex.
> + * Return: 0 on success, -ENOENT if the file is not preserved in this se=
ssion.
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{
> +	struct luo_session *session =3D (struct luo_session *)s;
> +	struct luo_file *luo_file;
> +	int err =3D -ENOENT;
> +
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		if (luo_file->file =3D=3D file) {
> +			if (tokenp)
> +				*tokenp =3D luo_file->token;
> +			err =3D 0;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kern=
el use.
> + * @s:      The incoming liveupdate session (restored from the previous =
kernel).
> + * @token:  The unique token identifying the file to retrieve.
> + * @filep:  On success, this will be populated with a pointer to the ret=
rieved
> + *          'struct file'.
> + *
> + * Provides a kernel-internal API for other subsystems to retrieve their
> + * preserved files after a live update. This function is a simple wrapper
> + * around luo_retrieve_file(), allowing callers to find a file by its to=
ken.
> + *
> + * The operation is idempotent; subsequent calls for the same token will=
 return
> + * a pointer to the same 'struct file' object.
> + *
> + * The caller receives a pointer to the file with a reference incremente=
d. The
> + * file's lifetime is managed by LUO and any userspace file
> + * descriptors. If the caller needs to hold a reference to the file beyo=
nd the
> + * immediate scope, it must call get_file() itself.
> + *
> + * Context: Can be called from any context in the new kernel that has a =
handle
> + *          to a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching to=
ken is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{
> +	struct luo_session *session =3D (struct luo_session *)s;
> +
> +	return luo_retrieve_file(session, token, filep);
> +}
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index 5185ad37a8c1..1a36f2383123 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -70,4 +70,13 @@ int luo_session_serialize(void);
>  int luo_session_deserialize(void);
>  bool luo_session_is_deserialized(void);
>=20=20
> +int luo_preserve_file(struct luo_session *session, u64 token, int fd);
> +void luo_file_unpreserve_files(struct luo_session *session);
> +int luo_file_freeze(struct luo_session *session);
> +void luo_file_unfreeze(struct luo_session *session);
> +int luo_retrieve_file(struct luo_session *session, u64 token,
> +		      struct file **filep);
> +int luo_file_finish(struct luo_session *session);
> +int luo_file_deserialize(struct luo_session *session);
> +
>  #endif /* _LINUX_LUO_INTERNAL_H */

--=20
Regards,
Pratyush Yadav

