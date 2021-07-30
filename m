Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCC3DB4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhG3IGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:06:35 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:30854 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhG3IGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:06:32 -0400
Received: from [10.0.2.15] ([86.243.172.93])
        by mwinf5d81 with ME
        id bL6H2500D21Fzsu03L6HAb; Fri, 30 Jul 2021 10:06:25 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Jul 2021 10:06:25 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v27 07/10] fs/ntfs3: Add NTFS journal
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-8-almaz.alexandrovich@paragon-software.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <526c746b-2615-6a27-f753-4655571a5462@wanadoo.fr>
Date:   Fri, 30 Jul 2021 10:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729134943.778917-8-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

below are a few comments based on a cppcheck run.
Don't take it too seriously into consideration. It could be either some 
useless code that could be removed or some issues in the logic.

It is reported only if a new iteration is done and if it makes sense to 
change something.

CJ

Le 29/07/2021 à 15:49, Konstantin Komarov a écrit :
> This adds NTFS journal
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/fslog.c | 5181 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 5181 insertions(+)
>   create mode 100644 fs/ntfs3/fslog.c
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> new file mode 100644
> index 000000000..53da12252
> --- /dev/null
> +++ b/fs/ntfs3/fslog.c

[...]

> +/*
> + * last_log_lsn
> + *
> + * This routine walks through the log pages for a file, searching for the
> + * last log page written to the file
> + */
> +static int last_log_lsn(struct ntfs_log *log)
> +{

[...]

> +tail_read:
> +	first_tail = first_tail_prev;
> +	final_off = final_off_prev;
> +
> +	second_tail = second_tail_prev;
> +	second_off = second_off_prev;
> +
> +	page_cnt = page_pos = 1;
> +
> +	curpage_off = seq_base == log->seq_num ? min(log->next_page, page_off)
> +					       : log->next_page;
> +
> +	wrapped_file =
> +		curpage_off == log->first_page &&
> +		!(log->l_flags & (NTFSLOG_NO_LAST_LSN | NTFSLOG_REUSE_TAIL));
> +
> +	expected_seq = wrapped_file ? (log->seq_num + 1) : log->seq_num;
> +
> +	nextpage_off = curpage_off;

This 'nextpage_off' is overwritten a few lines below.
Either it is useless, either there is an issue in the logic.

> +
> +next_page:
> +	tail_page = NULL;
> +	/* Read the next log page */
> +	err = read_log_page(log, curpage_off, &page, &usa_error);
> +
> +	/* Compute the next log page offset the file */
> +	nextpage_off = next_page_off(log, curpage_off);
> +	wrapped = nextpage_off == log->first_page;
here.

> +
> +	if (tails > 1) {
> +		struct RECORD_PAGE_HDR *cur_page =
> +			Add2Ptr(page_bufs, curpage_off - page_off);
> +
> +		if (curpage_off == saved_off) {
> +			tail_page = cur_page;
> +			goto use_tail_page;
> +		}
> +

[...]

> +int log_replay(struct ntfs_inode *ni, bool *initialized)
> +{

[...]

> +
> +	vcn = le64_to_cpu(lrh->target_vcn);
> +	vcn &= ~(log->clst_per_page - 1);
> +

This 'vcn' is overwritten a few lines below.
Either it is useless, either there is an issue in the logic.

> +add_allocated_vcns:
> +	for (i = 0, vcn = le64_to_cpu(lrh->target_vcn),

here

> +	    size = (vcn + 1) << sbi->cluster_bits;
> +	     i < t16; i++, vcn += 1, size += sbi->cluster_size) {
> +		attr = oa->attr;
> +		if (!attr->non_res) {
> +			if (size > le32_to_cpu(attr->res.data_size))
> +				attr->res.data_size = cpu_to_le32(size);
> +		} else {
> +			if (size > le64_to_cpu(attr->nres.data_size))
> +				attr->nres.valid_size = attr->nres.data_size =
> +					attr->nres.alloc_size =
> +						cpu_to_le64(size);
> +		}
> +	}
> +
> +	t16 = le16_to_cpu(lrh->undo_op);
> +	if (can_skip_action(t16))
> +		goto read_next_log_undo_action;
> +
> +	/* Point to the Redo data and get its length */
> +	data = Add2Ptr(lrh, le16_to_cpu(lrh->undo_off));
> +	dlen = le16_to_cpu(lrh->undo_len);
> +
> +	/* it is time to apply the undo action */
> +	err = do_action(log, oe, lrh, t16, data, dlen, rec_len, NULL);

This 'err' is unused.
Maybe there is nothing that we can do, or the error handling is missing.

> +
> +read_next_log_undo_action:
> +	/*
> +	 * Keep reading and looping back until we have read the
> +	 * last record for this transaction
> +	 */
> +	err = read_next_log_rec(log, lcb, &rec_lsn);
> +	if (err)
> +		goto out;
> +

[...]
