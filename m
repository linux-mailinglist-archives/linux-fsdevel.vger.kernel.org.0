Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5466E5692
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDRBlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDRBk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:40:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198D59FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552e3fa8f2fso32388007b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782055; x=1684374055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjDDJW+GHYKcFKqxIZ+BL5gG6uAgwAshe83Msya4lZk=;
        b=NlOg4YH4aS6Jqn57OyoDroboiAPLs6DTDbrvGBZbNhHR10+m/WdBxEvhRm0xAGWYMp
         f9bQ4TPfKNqD7xy2km5YYg0yfmm/J4l/kQ9agtg79DmAEtF6sxG6YZL0P09rDUitmuJT
         kXa0oepXRXmncPOGL54W0tDR+viFUV7oZolHNgNGYjHS3czEp7wnPo/SRvxpM/LZwElo
         qtthAQBa5tFhv3tSpPuuHV9MiyJGbjl+TBimhWKh7FOD20dvSUG3x1gbWqH++RfHPFb1
         qQwmzd7SdI+qv/79iFoti9uokwoWrsiLI5aQMJ9aVjw//OVLtTGARlAgnsUtTxomxwzx
         BL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782055; x=1684374055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjDDJW+GHYKcFKqxIZ+BL5gG6uAgwAshe83Msya4lZk=;
        b=LX70dTLq4W/wxCorkUScfETvjBrzTycREUaIAdfC7kFqmOELBvz0cuUlOnAXi21MBT
         dU1mOh0wb5Hr9T3QLO0/b45fuEWDkdGtU+iiJGPxJonK+/vYoDGoJkBtxVu5hcA3Qvv5
         lYtMpLHFJHy9r5250duzIsN1os+IynI5PTwq8/FZx9fpdoTfceNEFmgoXsv/SV42xZ9C
         CtFqditFpYMIVIH4a4Lg8z4ikHPtxEKJTHa1hpKZxedxDf/5VhMa9EVubzpyss2VLH4g
         SNhx1JTf9f1LW8wL64giQs/xUki/j7yMNt2+yGMLYETOK0ydHGZwK8v2XQ6Sd5ViieR7
         4V7Q==
X-Gm-Message-State: AAQBX9fFDHIUbEt/HrA7TKqECpFg5QBNPAXsBVX4t2Ak+r6DfBHTqN/5
        Kz9CN+QlvRBjqkvU9YysLj453lNPRzw=
X-Google-Smtp-Source: AKy350b6WbLfFOIpMTkeOSl2mlRWjzNHXOblepg4SNDqaWtzBw/uJNst+ZDP03Eg7cvOh/SLsMoc8N9aowY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a05:690c:706:b0:545:5f92:f7ee with SMTP id
 bs6-20020a05690c070600b005455f92f7eemr11333022ywb.2.1681782055788; Mon, 17
 Apr 2023 18:40:55 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:02 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-3-drosen@google.com>
Subject: [RFC PATCH v3 02/37] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
a pointer to a block of contiguous memory. This buffer is unused in the
case of local dynptrs, and may be unused in other cases as well. There
is no need to require the buffer, as the kfunc can just return NULL if
it was needed and not provided.

This adds another kfunc annotation, __opt, which combines with __sz and
__szk to allow the buffer associated with the size to be NULL. If the
buffer is NULL, the verifier does not check that the buffer is of
sufficient size.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
 kernel/bpf/helpers.c         | 32 ++++++++++++++++++++------------
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ea2516374d92..7a3d9de5f315 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -100,7 +100,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.2 __uninit Annotation
+2.2.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -117,6 +117,27 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
+2.2.4 __opt Annotation
+-------------------------
+
+This annotation is used to indicate that the buffer associated with an __sz or __szk
+argument may be null. If the function is passed a nullptr in place of the buffer,
+the verifier will not check that length is appropriate for the buffer. The kfunc is
+responsible for checking if this buffer is null before using it.
+
+An example is given below::
+
+        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 buffer__szk)
+        {
+        ...
+        }
+
+Here, the buffer may be null. If buffer is not null, it at least of size buffer_szk.
+Either way, the returned buffer is either NULL, or of size buffer_szk. Without this
+annotation, the verifier will reject the program if a null pointer is passed in with
+a nonzero size.
+
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 00e5fb0682ac..bfb75ecacb76 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2167,13 +2167,15 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * If the intention is to write to the data slice, please use
  * bpf_dynptr_slice_rdwr.
  *
@@ -2190,7 +2192,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
-				   void *buffer, u32 buffer__szk)
+				   void *buffer__opt, u32 buffer__szk)
 {
 	enum bpf_dynptr_type type;
 	u32 len = buffer__szk;
@@ -2210,15 +2212,19 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer);
+		if (!buffer__opt)
+			return NULL;
+		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
 		if (xdp_ptr)
 			return xdp_ptr;
 
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer, len, false);
-		return buffer;
+		if (!buffer__opt)
+			return NULL;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
+		return buffer__opt;
 	}
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
@@ -2230,13 +2236,15 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into. May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * The returned pointer is writable and may point to either directly the dynptr
  * data at the requested offset or to the buffer if unable to obtain a direct
  * data pointer to (example: the requested slice is to the paged area of an skb
@@ -2267,7 +2275,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
-					void *buffer, u32 buffer__szk)
+					void *buffer__opt, u32 buffer__szk)
 {
 	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
 		return NULL;
@@ -2294,7 +2302,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
+	return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
 }
 
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebc638bfed87..fd959824469d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9387,6 +9387,19 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return __kfunc_param_match_suffix(btf, arg, "__szk");
 }
 
+static bool is_kfunc_arg_optional(const struct btf *btf,
+		  const struct btf_param *arg,
+		  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_ptr(t) || reg->type != SCALAR_VALUE || reg->umax_value > 0)
+		return false;
+
+	return __kfunc_param_match_suffix(btf, arg, "__opt");
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__k");
@@ -10453,10 +10466,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
+			struct bpf_reg_state *buff_reg = &regs[regno];
+			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
 			ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
+			if (ret < 0 && is_kfunc_arg_optional(meta->btf, buff_arg, buff_reg)) {
+				verbose(env, "error was %d", ret);
+				ret = 0;
+			}
 			if (ret < 0) {
 				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
 				return ret;
-- 
2.40.0.634.g4ca3ef3211-goog

