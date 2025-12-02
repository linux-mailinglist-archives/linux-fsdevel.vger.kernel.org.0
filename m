Return-Path: <linux-fsdevel+bounces-70414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43141C99B22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B811F341612
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CDF19EED3;
	Tue,  2 Dec 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGGhVkZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3C136672
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637458; cv=none; b=KK+vLcUbsZsdzVw3vM4WD85FMrZg5NDeWGqvOQ+fC9f5sAwkxUYTPWQdnuezF5qyujDbSfDLw+OU0u4GisuWxjAv6ZbUq+hLF2XLWguLr5qwKXHy1MqyVc5+78uG3Ls7m3DTJEfJBX54h0r+HP1XIFdOk1blGkb9DLz3VToNB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637458; c=relaxed/simple;
	bh=+pEaqAUNwCaATVdXg9KFXuyMv3ykZt2p6tO9OdiWFfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwRHXTF7ubse7ptqzHWcBEu1oMTGW+bt2x/BnVCRnD9hE5GfPHuiov9ayr2yyLKgIIOhtkhw+yAQMfuraGDr84fzZFeSTxUdQUsAfKVwv/008y3PqdYmO+7OJRe5v/V4S0VKQn6e8YR4+rmbhrHtRFQZYy8mmueCI+VWIjtMmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGGhVkZM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8823d5127daso49311706d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 17:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764637455; x=1765242255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf32POyM3n0m9a2YRDQsiynjMKGnLJYDkDFvW5ec0Bs=;
        b=YGGhVkZMZVO2dmH5ETZY9wjUEzrln0O0FnIHrtaitZ2o8N6eEhZynFZ183tJ0ovIL0
         KPiDXMBde0R4l+yRJYB89S05fT8E4yueB3PdKwNSaZ9/FdnCfGj7Tp0YjbFodVf6tkYx
         mFYeGYK/upPqIR/9Ilz2z6dv72zCoA5DVTmeYeubJ96MiUKeyT7JQblAqvNPBTHt8Mbs
         ofNwq+qU+gs4CE4oafcO6AZffuHtRRyLwuQziXKoOHkr7UBokeQHPKAsYzkR9RMW1Qwm
         XMo3LxhFpYuGxRW5F9fGRgcvKsEzeYC7/FCNWPDL8zjMM4peIZ3lft9lMScLSVhl8QeB
         DpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764637455; x=1765242255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bf32POyM3n0m9a2YRDQsiynjMKGnLJYDkDFvW5ec0Bs=;
        b=Lpru8e+vCBFVo//oEjemtVYACKN0Snh0St4r2fsNIaJtbUFacONZk+L4O+UA36r0rE
         spa06OYs9seERiw3+VPetPuHH07+3FoAyVZqnkTK30ib/RVOosaCoExCw6C+rZH8NIHB
         0BgjnejTiZjsonwqWsAs2VSh4gUYJarmOFaSr0rRfy0IvvNgPAekkcg0h4AejimQxY9A
         5zkR4Nuv9ahXPtesVBtfescSluIv9H5PeczTNklhhHocaGZOh2l/O5oI90QZdCJsFvOK
         MGHhuwW+CtDKSpZd5Gx+blhmHQdnM4vZes1MdQz47ZdeKHLeiT+itilntJ6fTQyzGtty
         eqMA==
X-Forwarded-Encrypted: i=1; AJvYcCXvSZ6dolhW2MbMzFyTqwdt99dSbiWwyfML8OfdHBgE47kvB5TkqtGr7hh+/niJ7x/rcwoiyDjay/7EASVV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mfhJzjM0Hty8sPRc4iK60NqhwsXQyef5R4QsL9kkZrCqxCkB
	7D2fIxPCJIzg6pZaEGNApiZY1BbrtPJYScJ+lhY4IeQ5KYB/TOQ/6iJPgzKSyE9RT7MQwTcAzaE
	IOMTCktBD6g+n+R010RkXpGPw4WmSvAk=
X-Gm-Gg: ASbGncsGeYiwKrMMIdJSuH516TSKIZ8SrgVDOklvmokfHknG5q6Yf3b+Qhbe8EFT3gA
	wS8WfEsQ/4lHKWalY0nnwZsGXLE0D8tg8tgtC16gOSwRthGiQEnquHhey7RkI0hyU5QpW3dTWZ/
	3qsDXJfdJB2f0r/cN5BnsjHCgXZpPqcke0d/wg9ayh94i8CFWD60LX9ssXm7o7P1JEGwGhmxpnd
	znDw22mrmgWH8uztko4YaKoVx6KYm1SdkfIEws93QK/PARLkxa8CbfkNa3SAfGJHplcqpCCKVz7
	x/S1BpzG+ZW7CLiZRfMw7pmGogkWr4aMvyLqePvSITAhRcamKP/zd+bgLowsjER4bt3C2GdbFZD
	Tf5eY1RKRWcZyLVJ5FuvMEfo738aVz8rC/TIR0qicc07ioHz1Kkkrlpa7wsBVWcj5Exlb4iBcAV
	zJXwhciXNXdA==
X-Google-Smtp-Source: AGHT+IFnwywrE6wIXPvUFopXgWF0hITtKwWnHgF2kMPcdmgKB7hjS50S7gEIJUX2NpZJzn850ShHxxYRzmQmXuMd/FI=
X-Received: by 2002:ad4:5ba1:0:b0:882:762c:6b84 with SMTP id
 6a1803df08f44-8847c544879mr634564346d6.35.1764637454996; Mon, 01 Dec 2025
 17:04:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201225732.1520128-1-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 19:04:03 -0600
X-Gm-Features: AWmQ_bkOp6XDFqj-Lb39zcbMHWDBbys5j09O76J4KJipwt8es-HucDlLJmB6D20
Message-ID: <CAH2r5mspiEXcA2pxTfQrWrpZDLEW5YjFJCn0An4OcpEtkJ+B2A@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] cifs: Miscellaneous prep patches for rewrite of
 I/O layer
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The first seven (of the nine you sent recently) applied ok to
ksmbd-for-next and I can do some testing on them, as we await more
review and testing of the patches but patch 8 caused a few checkpatch
warnings (and patch 9 depends on it).  Do you want to clean it up?

./scripts/checkpatch.pl 9/0008-cifs-Add-a-tracepoint-to-log-EIO-errors.patc=
h
ERROR: trailing whitespace
#440: FILE: fs/smb/client/cifssmb.c:1379:
+^Idefault: $

ERROR: Macros with complex values should be enclosed in parentheses
#2069: FILE: fs/smb/client/trace.h:23:
+#define smb_eio_traces \
+ EM(smb_eio_trace_compress_copy, "compress_copy") \
+ EM(smb_eio_trace_copychunk_inv_rsp, "copychunk_inv_rsp") \
+ EM(smb_eio_trace_copychunk_overcopy_b, "copychunk_overcopy_b") \
+ EM(smb_eio_trace_copychunk_overcopy_c, "copychunk_overcopy_c") \
+ EM(smb_eio_trace_create_rsp_too_small, "create_rsp_too_small") \
+ EM(smb_eio_trace_dfsref_no_rsp, "dfsref_no_rsp") \
+ EM(smb_eio_trace_ea_overrun, "ea_overrun") \
+ EM(smb_eio_trace_extract_will_pin, "extract_will_pin") \
+ EM(smb_eio_trace_forced_shutdown, "forced_shutdown") \
+ EM(smb_eio_trace_getacl_bcc_too_small, "getacl_bcc_too_small") \
+ EM(smb_eio_trace_getcifsacl_param_count, "getcifsacl_param_count") \
+ EM(smb_eio_trace_getdfsrefer_bcc_too_small, "getdfsrefer_bcc_too_small") =
\
+ EM(smb_eio_trace_getextattr_bcc_too_small, "getextattr_bcc_too_small") \
+ EM(smb_eio_trace_getextattr_inv_size, "getextattr_inv_size") \
+ EM(smb_eio_trace_getsrvinonum_bcc_too_small, "getsrvinonum_bcc_too_small"=
) \
+ EM(smb_eio_trace_getsrvinonum_size, "getsrvinonum_size") \
+ EM(smb_eio_trace_ioctl_data_len, "ioctl_data_len") \
+ EM(smb_eio_trace_ioctl_no_rsp, "ioctl_no_rsp") \
+ EM(smb_eio_trace_ioctl_out_off, "ioctl_out_off") \
+ EM(smb_eio_trace_lock_bcc_too_small, "lock_bcc_too_small") \
+ EM(smb_eio_trace_lock_data_too_small, "lock_data_too_small") \
+ EM(smb_eio_trace_malformed_ksid_key, "malformed_ksid_key") \
+ EM(smb_eio_trace_malformed_sid_key, "malformed_sid_key") \
+ EM(smb_eio_trace_mkdir_no_rsp, "mkdir_no_rsp") \
+ EM(smb_eio_trace_neg_bad_rsplen, "neg_bad_rsplen") \
+ EM(smb_eio_trace_neg_decode_token, "neg_decode_token") \
+ EM(smb_eio_trace_neg_info_caps, "neg_info_caps") \
+ EM(smb_eio_trace_neg_info_dialect, "neg_info_dialect") \
+ EM(smb_eio_trace_neg_info_fail, "neg_info_fail") \
+ EM(smb_eio_trace_neg_info_sec_mode, "neg_info_sec_mode") \
+ EM(smb_eio_trace_neg_inval_dialect, "neg_inval_dialect") \
+ EM(smb_eio_trace_neg_no_crypt_key, "neg_no_crypt_key") \
+ EM(smb_eio_trace_neg_sec_blob_too_small, "neg_sec_blob_too_small") \
+ EM(smb_eio_trace_neg_unreq_dialect, "neg_unreq_dialect") \
+ EM(smb_eio_trace_no_auth_key, "no_auth_key") \
+ EM(smb_eio_trace_no_lease_key, "no_lease_key") \
+ EM(smb_eio_trace_not_netfs_writeback, "not_netfs_writeback") \
+ EM(smb_eio_trace_null_pointers, "null_pointers") \
+ EM(smb_eio_trace_oldqfsinfo_bcc_too_small, "oldqfsinfo_bcc_too_small") \
+ EM(smb_eio_trace_pend_del_fail, "pend_del_fail") \
+ EM(smb_eio_trace_qalleas_bcc_too_small, "qalleas_bcc_too_small") \
+ EM(smb_eio_trace_qalleas_ea_overlong, "qalleas_ea_overlong") \
+ EM(smb_eio_trace_qalleas_overlong, "qalleas_overlong") \
+ EM(smb_eio_trace_qfileinfo_bcc_too_small, "qfileinfo_bcc_too_small") \
+ EM(smb_eio_trace_qfileinfo_invalid, "qfileinfo_invalid") \
+ EM(smb_eio_trace_qfsattrinfo_bcc_too_small, "qfsattrinfo_bcc_too_small") =
\
+ EM(smb_eio_trace_qfsdevinfo_bcc_too_small, "qfsdevinfo_bcc_too_small") \
+ EM(smb_eio_trace_qfsinfo_bcc_too_small, "qfsinfo_bcc_too_small") \
+ EM(smb_eio_trace_qfsposixinfo_bcc_too_small, "qfsposixinfo_bcc_too_small"=
) \
+ EM(smb_eio_trace_qfsunixinfo_bcc_too_small, "qfsunixinfo_bcc_too_small") =
\
+ EM(smb_eio_trace_qpathinfo_bcc_too_small, "qpathinfo_bcc_too_small") \
+ EM(smb_eio_trace_qpathinfo_invalid, "qpathinfo_invalid") \
+ EM(smb_eio_trace_qreparse_data_area, "qreparse_data_area") \
+ EM(smb_eio_trace_qreparse_rep_datalen, "qreparse_rep_datalen") \
+ EM(smb_eio_trace_qreparse_ret_datalen, "qreparse_ret_datalen") \
+ EM(smb_eio_trace_qreparse_setup_count, "qreparse_setup_count") \
+ EM(smb_eio_trace_qreparse_sizes_wrong, "qreparse_sizes_wrong") \
+ EM(smb_eio_trace_qsym_bcc_too_small, "qsym_bcc_too_small") \
+ EM(smb_eio_trace_read_mid_state_unknown, "read_mid_state_unknown") \
+ EM(smb_eio_trace_read_overlarge, "read_overlarge") \
+ EM(smb_eio_trace_read_rsp_malformed, "read_rsp_malformed") \
+ EM(smb_eio_trace_read_rsp_short, "read_rsp_short") \
+ EM(smb_eio_trace_read_too_far, "read_too_far") \
+ EM(smb_eio_trace_reparse_data_len, "reparse_data_len") \
+ EM(smb_eio_trace_reparse_native_len, "reparse_native_len") \
+ EM(smb_eio_trace_reparse_native_nul, "reparse_native_nul") \
+ EM(smb_eio_trace_reparse_native_sym_len, "reparse_native_sym_len") \
+ EM(smb_eio_trace_reparse_nfs_dev, "reparse_nfs_dev") \
+ EM(smb_eio_trace_reparse_nfs_nul, "reparse_nfs_nul") \
+ EM(smb_eio_trace_reparse_nfs_sockfifo, "reparse_nfs_sockfifo") \
+ EM(smb_eio_trace_reparse_nfs_symbuf, "reparse_nfs_symbuf") \
+ EM(smb_eio_trace_reparse_nfs_too_short, "reparse_nfs_too_short") \
+ EM(smb_eio_trace_reparse_overlong, "reparse_overlong") \
+ EM(smb_eio_trace_reparse_rdlen, "reparse_rdlen") \
+ EM(smb_eio_trace_reparse_wsl_nul, "reparse_wsl_nul") \
+ EM(smb_eio_trace_reparse_wsl_symbuf, "reparse_wsl_symbuf") \
+ EM(smb_eio_trace_reparse_wsl_ver, "reparse_wsl_ver") \
+ EM(smb_eio_trace_rx_b_read_short, "rx_b_read_short") \
+ EM(smb_eio_trace_rx_bad_datalen, "rx_bad_datalen") \
+ EM(smb_eio_trace_rx_both_buf, "rx_both_buf") \
+ EM(smb_eio_trace_rx_calc_len_too_big, "rx_calc_len_too_big") \
+ EM(smb_eio_trace_rx_check_rsp, "rx_check_rsp") \
+ EM(smb_eio_trace_rx_copy_to_iter, "rx_copy_to_iter") \
+ EM(smb_eio_trace_rx_insuff_res, "rx_insuff_res") \
+ EM(smb_eio_trace_rx_inv_bcc, "rx_inv_bcc") \
+ EM(smb_eio_trace_rx_mid_unready, "rx_mid_unready") \
+ EM(smb_eio_trace_rx_neg_sess_resp, "rx_neg_sess_resp") \
+ EM(smb_eio_trace_rx_overlong, "rx_overlong") \
+ EM(smb_eio_trace_rx_overpage, "rx_overpage") \
+ EM(smb_eio_trace_rx_pos_sess_resp, "rx_pos_sess_resp") \
+ EM(smb_eio_trace_rx_rfc1002_magic, "rx_rfc1002_magic") \
+ EM(smb_eio_trace_rx_sync_mid_invalid, "rx_sync_mid_invalid") \
+ EM(smb_eio_trace_rx_sync_mid_malformed, "rx_sync_mid_malformed") \
+ EM(smb_eio_trace_rx_too_short, "rx_too_short") \
+ EM(smb_eio_trace_rx_trans2_extract, "rx_trans2_extract") \
+ EM(smb_eio_trace_rx_unknown_resp, "rx_unknown_resp") \
+ EM(smb_eio_trace_rx_unspec_error, "rx_unspec_error") \
+ EM(smb_eio_trace_sess_buf_off, "sess_buf_off") \
+ EM(smb_eio_trace_sess_exiting, "sess_exiting") \
+ EM(smb_eio_trace_sess_krb_wcc, "sess_krb_wcc") \
+ EM(smb_eio_trace_sess_nl2_wcc, "sess_nl2_wcc") \
+ EM(smb_eio_trace_sess_rawnl_auth_wcc, "sess_rawnl_auth_wcc") \
+ EM(smb_eio_trace_sess_rawnl_neg_wcc, "sess_rawnl_neg_wcc") \
+ EM(smb_eio_trace_short_symlink_write, "short_symlink_write") \
+ EM(smb_eio_trace_sid_too_many_auth, "sid_too_many_auth") \
+ EM(smb_eio_trace_sig_data_too_small, "sig_data_too_small") \
+ EM(smb_eio_trace_sig_iter, "sig_iter") \
+ EM(smb_eio_trace_smb1_received_error, "smb1_received_error") \
+ EM(smb_eio_trace_smb2_received_error, "smb2_received_error") \
+ EM(smb_eio_trace_sym_slash, "sym_slash") \
+ EM(smb_eio_trace_sym_target_len, "sym_target_len") \
+ EM(smb_eio_trace_symlink_file_size, "symlink_file_size") \
+ EM(smb_eio_trace_tdis_in_reconnect, "tdis_in_reconnect") \
+ EM(smb_eio_trace_tx_chained_async, "tx_chained_async") \
+ EM(smb_eio_trace_tx_compress_failed, "tx_compress_failed") \
+ EM(smb_eio_trace_tx_copy_iter_to_buf, "tx_copy_iter_to_buf") \
+ EM(smb_eio_trace_tx_copy_to_buf, "tx_copy_to_buf") \
+ EM(smb_eio_trace_tx_max_compound, "tx_max_compound") \
+ EM(smb_eio_trace_tx_miscopy_to_buf, "tx_miscopy_to_buf") \
+ EM(smb_eio_trace_tx_need_transform, "tx_need_transform") \
+ EM(smb_eio_trace_tx_too_long, "sr_too_long") \
+ EM(smb_eio_trace_unixqfileinfo_bcc_too_small, "unixqfileinfo_bcc_too_smal=
l") \
+ EM(smb_eio_trace_unixqpathinfo_bcc_too_small, "unixqpathinfo_bcc_too_smal=
l") \
+ EM(smb_eio_trace_user_iter, "user_iter") \
+ EM(smb_eio_trace_write_bad_buf_type, "write_bad_buf_type") \
+ EM(smb_eio_trace_write_mid_state_unknown, "write_mid_state_unknown") \
+ EM(smb_eio_trace_write_rsp_malformed, "write_rsp_malformed") \
+ E_(smb_eio_trace_write_too_far, "write_too_far")

BUT SEE:

   do {} while (0) advice is over-stated in a few situations:

   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
   file-scope, where C disallows code (it must be in functions).  See
   $exceptions if you have one to add by name.

   More troublesome is declarative macros used at top of new scope,
   like DECLARE_PER_CPU.  These might just compile with a do-while-0
   wrapper, but would be incorrect.  Most of these are handled by
   detecting struct,union,etc declaration primitives in $exceptions.

   Theres also macros called inside an if (block), which "return" an
   expression.  These cannot do-while, and need a ({}) wrapper.

   Enjoy this qualification while we work to improve our heuristics.

total: 2 errors, 0 warnings, 2015 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

9/0008-cifs-Add-a-tracepoint-to-log-EIO-errors.patch has style
problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

On Mon, Dec 1, 2025 at 4:58=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Steve,
>
> Could you take these patches extracted from my I/O layer rewrite for the
> upcoming merge window.  The performance change should be neutral, but it
> cleans up the code a bit.
>
>  (1) Remove the RFC1002 header from the smb_hdr struct so that it's
>      consistent with SMB2/3.  This allows I/O routines to be simplified a=
nd
>      shared.
>
>  (2) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
>      with SMB2/3.
>
>  (3) Clean up a bunch of extra kvec[] that were required for RFC1002
>      headers from SMB1's header struct.
>
>  (4) Replace SendReceiveBlockingLock() with SendReceive() plus flags.
>
>  (5) Change the mid_*_t function pointers to have the pointer in the type=
def
>      as is more normal rather than at the point of use.
>
>  (6) Remove the server pointer from smb_message.  It can be passed down
>      from the caller to all places that need it.
>
>  (7) Don't need state locking in smb2_get_mid_entry() as we're just doing=
 a
>      single read inside the lock.  READ_ONCE() should suffice instead.
>
>  (8) Add a tracepoint to log EIO errors and up to a couple of bits of inf=
o
>      for each to make it easier to find out why an EIO error happened whe=
n
>      the system is very busy without introducing printk delays.
>
>  (9) Make some minor code cleanups.
>
> The patches will be found here also when the git server is accessible
> again:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-next
>
> Thanks,
> David
>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #6)
>  - Remove the patch to rename mid_q_entry.
>  - Add a patch to normalise the func pointer typedefs.
>
> ver #5)
>  - Rebased on the ksmbd-for-next branch.
>  - Drop the netfs_alloc patch as that's now taken.
>  - Added a warning check requested by Stefan Metzmacher.
>  - Switched to a branch without the header prototype cleanups.
>  - Add a patch to make some minor code cleanups.
>  - Don't do EIO changed in smbdirect.c as that interferes with Stefan's
>    changes.
>
> ver #4)
>  - Rebased on the ksmbd-for-next branch.
>  - The read tracepoint patch got merged, so drop it.
>  - Move the netfs_alloc, etc. patch first.
>  - Fix a couple of prototypes that need to be conditional (may need some
>    post cleanup).
>  - Fixed another couple of headers that needed their own prototype lists.
>  - Fixed #include order in a couple of places.
>
> ver #3)
>  - Rebased on the ksmbd-for-next branch.
>  - Add the patches to clean up the function prototypes in the headers.
>    - Don't touch smbdirect.
>    - Put prototypes into netlink.h and cached_dir.h rather than
>      centralising them.
>    - Indent the arguments in the prototypes to the opening bracket + 1.
>  - Cleaned up most other checkpatch complaints.
>  - Added the EIO tracepoint patch to the end.
>
> ver #2)
>  - Rebased on the ksmbd-for-next-next branch.
>  - Moved the patch to use netfs_alloc/free_folioq_buffer() down the stack=
.
>
> David Howells (9):
>   cifs: Remove the RFC1002 header from smb_hdr
>   cifs: Make smb1's SendReceive() wrap cifs_send_recv()
>   cifs: Clean up some places where an extra kvec[] was required for
>     rfc1002
>   cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
>   cifs: Fix specification of function pointers
>   cifs: Remove the server pointer from smb_message
>   cifs: Don't need state locking in smb2_get_mid_entry()
>   cifs: Add a tracepoint to log EIO errors
>   cifs: Do some preparation prior to organising the function
>     declarations
>
>  fs/smb/client/cached_dir.c    |   2 +-
>  fs/smb/client/cifs_debug.c    |  14 +-
>  fs/smb/client/cifs_debug.h    |   6 +-
>  fs/smb/client/cifs_spnego.h   |   2 -
>  fs/smb/client/cifs_unicode.h  |   3 -
>  fs/smb/client/cifsacl.c       |  10 +-
>  fs/smb/client/cifsencrypt.c   |  83 +---
>  fs/smb/client/cifsfs.c        |  12 +-
>  fs/smb/client/cifsglob.h      | 151 ++----
>  fs/smb/client/cifspdu.h       |   2 +-
>  fs/smb/client/cifsproto.h     | 194 ++++++--
>  fs/smb/client/cifssmb.c       | 913 +++++++++++++++++++---------------
>  fs/smb/client/cifstransport.c | 382 ++------------
>  fs/smb/client/compress.c      |  23 +-
>  fs/smb/client/compress.h      |  19 +-
>  fs/smb/client/connect.c       |  81 ++-
>  fs/smb/client/dir.c           |   8 +-
>  fs/smb/client/dns_resolve.h   |   4 -
>  fs/smb/client/file.c          |   6 +-
>  fs/smb/client/fs_context.c    |   2 +-
>  fs/smb/client/inode.c         |  14 +-
>  fs/smb/client/link.c          |  10 +-
>  fs/smb/client/misc.c          |  53 +-
>  fs/smb/client/netmisc.c       |  11 +-
>  fs/smb/client/readdir.c       |   2 +-
>  fs/smb/client/reparse.c       |  53 +-
>  fs/smb/client/sess.c          |  16 +-
>  fs/smb/client/smb1ops.c       |  78 ++-
>  fs/smb/client/smb2file.c      |   9 +-
>  fs/smb/client/smb2inode.c     |  13 +-
>  fs/smb/client/smb2maperror.c  |   6 +-
>  fs/smb/client/smb2misc.c      |   3 +-
>  fs/smb/client/smb2ops.c       |  78 +--
>  fs/smb/client/smb2pdu.c       | 208 ++++----
>  fs/smb/client/smb2proto.h     |   4 +-
>  fs/smb/client/smb2transport.c |  59 +--
>  fs/smb/client/trace.h         | 149 ++++++
>  fs/smb/client/transport.c     | 179 +++----
>  fs/smb/client/xattr.c         |   2 +-
>  fs/smb/common/smb2pdu.h       |   3 -
>  fs/smb/common/smbglob.h       |   1 -
>  41 files changed, 1463 insertions(+), 1405 deletions(-)
>
>


--=20
Thanks,

Steve

