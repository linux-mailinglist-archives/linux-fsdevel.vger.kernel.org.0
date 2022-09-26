Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C225EB568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIZXSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiIZXSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8BCBAE9
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g6-20020a056902134600b006bbad6c9b78so1338899ybu.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=X0LeeNfNH0X8FCGaqGqE9r8JpQsjrSk9pU0JPQVzZBc=;
        b=TE7Dk+xYIZz4ihhKQiK6GkkaiDCOOFbInucPXLCyiGrmI+WT1P6mfCFJKJhPY7mtLW
         kobBXpMF376Xu9P7jB7mFJSN3rTVL0MCtV/yA1xH2iSvVpnWFaMKSr0B8J0CvqkbNLFr
         xyFZskb7XFdLceYAnTyra/jdYIZvwaBlES1NJPJva+LdJ0i+5ZbC0vC9y0DJykeeiArv
         /YvSyfMwcb+kulQsnTAHodXOFjQGNJxe22Sbc9TzB2DaTOsMkvrW/5UdJXQAhxA+Q8Vg
         zYI7RVzkIbf5AwOffZnU0o24cKJvP3atHKiDVu2IybS39hVxMtwK1kQxq+wleaXOB0yz
         P0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=X0LeeNfNH0X8FCGaqGqE9r8JpQsjrSk9pU0JPQVzZBc=;
        b=C7vjpJ76T/phU+Bt5iJPVsAGDm919RWkR4My7GcCQ35zu4S6ETn19wuE25IYnwK6eg
         QWlXHg+syOxNCFA1OrlE1kylb7qw+kz9PmXEyY7UduAzggcIQY0iV1gjFti8cveEmB8d
         5KQ/j+NAfn+A7//NbvMxESIm7Ou9N9ZXbLFTF2Nws+1PtzEbMThrz4GyetfeyMjt9KMb
         m6uNRFUt9sPkiVS0TmKtedcatmiZzAyQdcb+XsHfUZlz8Vna1+HAMNm2x97rBemZ240M
         zIzkLk9Vo7mSU2fcvz/9OAcYxeDzPuPapah3EcLQsSCexJ0dxO61rg8WF8TjAbCExuAs
         ze4w==
X-Gm-Message-State: ACrzQf22xAng8OIhCS8Kxth6SPtNMYB1SaNkR7hPQfn+YSd1kMpMsdTf
        VoeolxADtZqVmvKOV4Suwppjs0U7JI4=
X-Google-Smtp-Source: AMsMyM4PoPEJ6Nf3SonVJkNvzdTRXInekfRs4jgRZBfIjr1ZRMZv+hw3GdlDsbg/qgbef5efKIkqypYauhc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:557:0:b0:34d:544f:cacc with SMTP id
 84-20020a810557000000b0034d544fcaccmr23552255ywf.440.1664234311795; Mon, 26
 Sep 2022 16:18:31 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:17:57 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-2-drosen@google.com>
Subject: [PATCH 01/26] bpf: verifier: Allow for multiple packets
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows multiple PTR_TO_PACKETs for a single bpf program. Fuse bpf
uses this to handle the various input and output types it has.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  5 ++-
 kernel/bpf/verifier.c        | 60 +++++++++++++++++++++++-------------
 3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..07086e375487 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -633,6 +633,7 @@ struct bpf_insn_access_aux {
 			struct btf *btf;
 			u32 btf_id;
 		};
+		int data_id;
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bad8640dc..feae965e08a4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -50,7 +50,10 @@ struct bpf_reg_state {
 	s32 off;
 	union {
 		/* valid when type == PTR_TO_PACKET */
-		int range;
+		struct {
+			int range;
+			u32 data_id;
+		};
 
 		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
 		 *   PTR_TO_MAP_VALUE_OR_NULL
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3eadb14e090b..d28cb22d5ee5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3544,8 +3544,9 @@ static int __check_mem_access(struct bpf_verifier_env *env, int regno,
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET_END:
-		verbose(env, "invalid access to packet, off=%d size=%d, R%d(id=%d,off=%d,r=%d)\n",
-			off, size, regno, reg->id, off, mem_size);
+		verbose(env,
+			"invalid access to packet %d, off=%d size=%d, R%d(id=%d,off=%d,r=%d)\n",
+			reg->data_id, off, size, regno, reg->id, off, mem_size);
 		break;
 	case PTR_TO_MEM:
 	default:
@@ -3938,7 +3939,7 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, u32 *data_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -3959,6 +3960,8 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
 			*btf_id = info.btf_id;
+		} else if (*reg_type == PTR_TO_PACKET || *reg_type == PTR_TO_PACKET_END) {
+			*data_id = info.data_id;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
 		}
@@ -4788,6 +4791,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
 		u32 btf_id = 0;
+		u32 data_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -4800,7 +4804,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &data_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -4824,6 +4828,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+				} else if (reg_type == PTR_TO_PACKET ||
+				    reg_type == PTR_TO_PACKET_END ||
+				    reg_type == PTR_TO_PACKET_META) {
+					regs[value_regno].data_id = data_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -9921,18 +9929,20 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 
 	switch (BPF_OP(insn->code)) {
 	case BPF_JGT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
+		if (dst_reg->data_id == src_reg->data_id &&
+		    ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
+		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))) {
 			/* pkt_data' > pkt_end, pkt_meta' > pkt_data */
 			find_good_pkt_pointers(this_branch, dst_reg,
 					       dst_reg->type, false);
 			mark_pkt_end(other_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
+		} else if (dst_reg->data_id == src_reg->data_id &&
+			   ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    src_reg->type == PTR_TO_PACKET_META))) {
 			/* pkt_end > pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_pointers(other_branch, src_reg,
 					       src_reg->type, true);
@@ -9942,18 +9952,20 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 		}
 		break;
 	case BPF_JLT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
+		if (dst_reg->data_id == src_reg->data_id &&
+		    ((dst_reg->type == PTR_TO_PACKET &&
+		     src_reg->type == PTR_TO_PACKET_END && dst_reg->data_id == src_reg->data_id) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
+		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))) {
 			/* pkt_data' < pkt_end, pkt_meta' < pkt_data */
 			find_good_pkt_pointers(other_branch, dst_reg,
 					       dst_reg->type, true);
 			mark_pkt_end(this_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
+		} else if (dst_reg->data_id == src_reg->data_id &&
+			   ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    src_reg->type == PTR_TO_PACKET_META))) {
 			/* pkt_end < pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_pointers(this_branch, src_reg,
 					       src_reg->type, false);
@@ -9963,18 +9975,20 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 		}
 		break;
 	case BPF_JGE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
+		if (dst_reg->data_id == src_reg->data_id &&
+		    ((dst_reg->type == PTR_TO_PACKET &&
 		     src_reg->type == PTR_TO_PACKET_END) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
+		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))) {
 			/* pkt_data' >= pkt_end, pkt_meta' >= pkt_data */
 			find_good_pkt_pointers(this_branch, dst_reg,
 					       dst_reg->type, true);
 			mark_pkt_end(other_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
+		} else if (dst_reg->data_id == src_reg->data_id &&
+			   ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    src_reg->type == PTR_TO_PACKET_META))) {
 			/* pkt_end >= pkt_data', pkt_data >= pkt_meta' */
 			find_good_pkt_pointers(other_branch, src_reg,
 					       src_reg->type, false);
@@ -9984,18 +9998,20 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 		}
 		break;
 	case BPF_JLE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
+		if (dst_reg->data_id == src_reg->data_id &&
+		    ((dst_reg->type == PTR_TO_PACKET &&
+		     src_reg->type == PTR_TO_PACKET_END && dst_reg->data_id == src_reg->data_id) ||
 		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
+		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))) {
 			/* pkt_data' <= pkt_end, pkt_meta' <= pkt_data */
 			find_good_pkt_pointers(other_branch, dst_reg,
 					       dst_reg->type, false);
 			mark_pkt_end(this_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
+		} else if (dst_reg->data_id == src_reg->data_id &&
+			   ((dst_reg->type == PTR_TO_PACKET_END &&
 			    src_reg->type == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    src_reg->type == PTR_TO_PACKET_META))) {
 			/* pkt_end <= pkt_data', pkt_data <= pkt_meta' */
 			find_good_pkt_pointers(this_branch, src_reg,
 					       src_reg->type, true);
-- 
2.37.3.998.g577e59143f-goog

