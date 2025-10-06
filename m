Return-Path: <linux-fsdevel+bounces-63507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E580BBEACD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0361896CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3E2DD5E2;
	Mon,  6 Oct 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCB4m1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F042DA779;
	Mon,  6 Oct 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768736; cv=none; b=d5RqpTSb5tvuzxXpIrHAH+akq8KulaKmBvI2gl1fAoz1dsmyycfDmanK3gHrVtbE9k/1HyhEIWRI5cKCab7PMeOPHuFack+HT33wR/pcbdY9FTJfDI0reNQESKZFst8JYNpzf/nZyzpViUJH8/C2aO8gkfn1X+NySHlMsJtJP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768736; c=relaxed/simple;
	bh=sxyC+M2p7vPAPhVy3ZlJCaWWCXkjXzbjOcvF/s8+J38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dY0m46j9WS/Qpgsb0HW+b9NOMArOn158iLb6e8AGBisRfv7FuwX1l+ubjPQfHFKn+v0fY4oltLmNSbWY8nc/y0ZexCpM0TY/OkClexNCkZsco1Pat/1iJXkI7XDqZEpym5QLwknJ0kfS6RsYfk89kC9FUCEdNX0FpXxnB7NIVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoCB4m1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A48C4CEF5;
	Mon,  6 Oct 2025 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759768735;
	bh=sxyC+M2p7vPAPhVy3ZlJCaWWCXkjXzbjOcvF/s8+J38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AoCB4m1fzQ5jyR7WTLfGlF6oqK6LGxGaJeYs0kb4rShKoKCiR+8kc5RLjvkQ2kWZl
	 N+nqPUUgBVuyONwRKAxWStMysJgoomOb5mLrd+4i8baVJ84dhQOrNBRV+gUNqSUSx7
	 lf0XasB4zMpfRUaKdi11jD9sFZj/ShqT7GhVRoE8tvqUqtX6qPd9vb2GuaN2Tqd1cC
	 TM9y9rH3WkMkDQ3gesAR5Df8vVIqmGVhksS29tdZikWj37vi2ndjjIBUQtW4enue3G
	 dPTW7LuVrQgQ6oUjaXudtwNXootEyhcQ/bM0q3UTbUg5I2ou5p9PYg2TwMjKKpFDrS
	 vXTfikQeMJI9Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
In-Reply-To: <mafs0bjmkp0gb.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	06 Oct 2025 16:30:12 +0200")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-4-pasha.tatashin@soleen.com>
	<mafs0bjmkp0gb.fsf@kernel.org>
Date: Mon, 06 Oct 2025 18:38:45 +0200
Message-ID: <mafs0347woui2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 06 2025, Pratyush Yadav wrote:

> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>
>> The KHO framework uses a notifier chain as the mechanism for clients to
>> participate in the finalization process. While this works for a single,
>> central state machine, it is too restrictive for kernel-internal
>> components like pstore/reserve_mem or IMA. These components need a
>> simpler, direct way to register their state for preservation (e.g.,
>> during their initcall) without being part of a complex,
>> shutdown-time notifier sequence. The notifier model forces all
>> participants into a single finalization flow and makes direct
>> preservation from an arbitrary context difficult.
>> This patch refactors the client participation model by removing the
>> notifier chain and introducing a direct API for managing FDT subtrees.
>>
>> The core kho_finalize() and kho_abort() state machine remains, but
>> clients now register their data with KHO beforehand.
>>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> This patch breaks build of test_kho.c (under CONFIG_TEST_KEXEC_HANDOVER):
>
> 	lib/test_kho.c:49:14: error: =E2=80=98KEXEC_KHO_ABORT=E2=80=99 undeclare=
d (first use in this function)
> 	   49 |         case KEXEC_KHO_ABORT:
> 	      |              ^~~~~~~~~~~~~~~
> 	[...]
> 	lib/test_kho.c:51:14: error: =E2=80=98KEXEC_KHO_FINALIZE=E2=80=99 undecl=
ared (first use in this function)
> 	   51 |         case KEXEC_KHO_FINALIZE:
> 	      |              ^~~~~~~~~~~~~~~~~~
> 	[...]
>
> I think you need to update it as well to drop notifier usage.

Here's the fix. Build passes now and the test succeeds under my qemu
test setup.

--- 8< ---
From a8e6b5dfef38bfbcd41f3dd08598cb79a0701d7e Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <pratyush@kernel.org>
Date: Mon, 6 Oct 2025 18:35:20 +0200
Subject: [PATCH] fixup! kho: drop notifiers

Update KHO test to drop the notifiers as well.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 lib/test_kho.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index fe8504e3407b5..e9462a1e4b93b 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -38,33 +38,6 @@ struct kho_test_state {
=20
 static struct kho_test_state kho_test_state;
=20
-static int kho_test_notifier(struct notifier_block *self, unsigned long cm=
d,
-			     void *v)
-{
-	struct kho_test_state *state =3D &kho_test_state;
-	struct kho_serialization *ser =3D v;
-	int err =3D 0;
-
-	switch (cmd) {
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	case KEXEC_KHO_FINALIZE:
-		/* Handled below */
-		break;
-	default:
-		return NOTIFY_BAD;
-	}
-
-	err |=3D kho_preserve_folio(state->fdt);
-	err |=3D kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
-
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
-}
-
-static struct notifier_block kho_test_nb =3D {
-	.notifier_call =3D kho_test_notifier,
-};
-
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
 	phys_addr_t *folios_info;
@@ -111,6 +84,7 @@ static int kho_test_prepare_fdt(struct kho_test_state *s=
tate)
=20
 	fdt =3D folio_address(state->fdt);
=20
+	err |=3D kho_preserve_folio(state->fdt);
 	err |=3D fdt_create(fdt, fdt_size);
 	err |=3D fdt_finish_reservemap(fdt);
=20
@@ -194,7 +168,7 @@ static int kho_test_save(void)
 	if (err)
 		goto err_free_folios;
=20
-	err =3D register_kho_notifier(&kho_test_nb);
+	err =3D kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));
 	if (err)
 		goto err_free_fdt;
=20
@@ -309,7 +283,7 @@ static void kho_test_cleanup(void)
=20
 static void __exit kho_test_exit(void)
 {
-	unregister_kho_notifier(&kho_test_nb);
+	kho_remove_subtree(folio_address(kho_test_state.fdt));
 	kho_test_cleanup();
 }
 module_exit(kho_test_exit);
--=20
Regards,
Pratyush Yadav

