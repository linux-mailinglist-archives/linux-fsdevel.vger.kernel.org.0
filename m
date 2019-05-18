Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E6222FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfERKEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 06:04:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:10785 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfERKEr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 06:04:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 May 2019 03:04:46 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2019 03:04:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hRwCq-0006Gp-09; Sat, 18 May 2019 18:04:44 +0800
Date:   Sat, 18 May 2019 18:04:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V3 5/6] IMA: Add a ima-vfs-sig measurement template
Message-ID: <201905181851.ooheCtWW%lkp@intel.com>
References: <20190517212448.14256-6-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517212448.14256-6-matthewgarrett@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on v5.1 next-20190517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Garrett/IMA-Support-asking-the-VFS-for-a-file-hash/20190518-150531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   security/integrity/ima/ima_template_lib.c:110:60: sparse: sparse: restricted __le32 degrades to integer
   security/integrity/ima/ima_template_lib.c:193:49: sparse: sparse: cast to restricted __le32
>> security/integrity/ima/ima_template_lib.c:299:66: sparse: sparse: Using plain integer as NULL pointer

vim +299 security/integrity/ima/ima_template_lib.c

3ce1217d6 Roberto Sassu   2013-06-07  100  
3ce1217d6 Roberto Sassu   2013-06-07  101  static void ima_show_template_data_binary(struct seq_file *m,
3ce1217d6 Roberto Sassu   2013-06-07  102  					  enum ima_show_type show,
3ce1217d6 Roberto Sassu   2013-06-07  103  					  enum data_formats datafmt,
3ce1217d6 Roberto Sassu   2013-06-07  104  					  struct ima_field_data *field_data)
3ce1217d6 Roberto Sassu   2013-06-07  105  {
c019e307a Roberto Sassu   2014-02-03  106  	u32 len = (show == IMA_SHOW_BINARY_OLD_STRING_FMT) ?
c019e307a Roberto Sassu   2014-02-03  107  	    strlen(field_data->data) : field_data->len;
c019e307a Roberto Sassu   2014-02-03  108  
d68a6fe9f Mimi Zohar      2016-12-19  109  	if (show != IMA_SHOW_BINARY_NO_FIELD_LEN) {
d68a6fe9f Mimi Zohar      2016-12-19 @110  		u32 field_len = !ima_canonical_fmt ? len : cpu_to_le32(len);
d68a6fe9f Mimi Zohar      2016-12-19  111  
d68a6fe9f Mimi Zohar      2016-12-19  112  		ima_putc(m, &field_len, sizeof(field_len));
d68a6fe9f Mimi Zohar      2016-12-19  113  	}
3e8e5503a Roberto Sassu   2013-11-08  114  
c019e307a Roberto Sassu   2014-02-03  115  	if (!len)
3ce1217d6 Roberto Sassu   2013-06-07  116  		return;
3e8e5503a Roberto Sassu   2013-11-08  117  
c019e307a Roberto Sassu   2014-02-03  118  	ima_putc(m, field_data->data, len);
3ce1217d6 Roberto Sassu   2013-06-07  119  }
3ce1217d6 Roberto Sassu   2013-06-07  120  
3ce1217d6 Roberto Sassu   2013-06-07  121  static void ima_show_template_field_data(struct seq_file *m,
3ce1217d6 Roberto Sassu   2013-06-07  122  					 enum ima_show_type show,
3ce1217d6 Roberto Sassu   2013-06-07  123  					 enum data_formats datafmt,
3ce1217d6 Roberto Sassu   2013-06-07  124  					 struct ima_field_data *field_data)
3ce1217d6 Roberto Sassu   2013-06-07  125  {
3ce1217d6 Roberto Sassu   2013-06-07  126  	switch (show) {
3ce1217d6 Roberto Sassu   2013-06-07  127  	case IMA_SHOW_ASCII:
3ce1217d6 Roberto Sassu   2013-06-07  128  		ima_show_template_data_ascii(m, show, datafmt, field_data);
3ce1217d6 Roberto Sassu   2013-06-07  129  		break;
3ce1217d6 Roberto Sassu   2013-06-07  130  	case IMA_SHOW_BINARY:
3e8e5503a Roberto Sassu   2013-11-08  131  	case IMA_SHOW_BINARY_NO_FIELD_LEN:
c019e307a Roberto Sassu   2014-02-03  132  	case IMA_SHOW_BINARY_OLD_STRING_FMT:
3ce1217d6 Roberto Sassu   2013-06-07  133  		ima_show_template_data_binary(m, show, datafmt, field_data);
3ce1217d6 Roberto Sassu   2013-06-07  134  		break;
3ce1217d6 Roberto Sassu   2013-06-07  135  	default:
3ce1217d6 Roberto Sassu   2013-06-07  136  		break;
3ce1217d6 Roberto Sassu   2013-06-07  137  	}
3ce1217d6 Roberto Sassu   2013-06-07  138  }
3ce1217d6 Roberto Sassu   2013-06-07  139  
3ce1217d6 Roberto Sassu   2013-06-07  140  void ima_show_template_digest(struct seq_file *m, enum ima_show_type show,
3ce1217d6 Roberto Sassu   2013-06-07  141  			      struct ima_field_data *field_data)
3ce1217d6 Roberto Sassu   2013-06-07  142  {
3ce1217d6 Roberto Sassu   2013-06-07  143  	ima_show_template_field_data(m, show, DATA_FMT_DIGEST, field_data);
3ce1217d6 Roberto Sassu   2013-06-07  144  }
3ce1217d6 Roberto Sassu   2013-06-07  145  
4d7aeee73 Roberto Sassu   2013-06-07  146  void ima_show_template_digest_ng(struct seq_file *m, enum ima_show_type show,
4d7aeee73 Roberto Sassu   2013-06-07  147  				 struct ima_field_data *field_data)
4d7aeee73 Roberto Sassu   2013-06-07  148  {
4d7aeee73 Roberto Sassu   2013-06-07  149  	ima_show_template_field_data(m, show, DATA_FMT_DIGEST_WITH_ALGO,
4d7aeee73 Roberto Sassu   2013-06-07  150  				     field_data);
4d7aeee73 Roberto Sassu   2013-06-07  151  }
4d7aeee73 Roberto Sassu   2013-06-07  152  
3ce1217d6 Roberto Sassu   2013-06-07  153  void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
3ce1217d6 Roberto Sassu   2013-06-07  154  			      struct ima_field_data *field_data)
3ce1217d6 Roberto Sassu   2013-06-07  155  {
3ce1217d6 Roberto Sassu   2013-06-07  156  	ima_show_template_field_data(m, show, DATA_FMT_STRING, field_data);
3ce1217d6 Roberto Sassu   2013-06-07  157  }
3ce1217d6 Roberto Sassu   2013-06-07  158  
bcbc9b0cf Mimi Zohar      2013-07-23  159  void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
bcbc9b0cf Mimi Zohar      2013-07-23  160  			   struct ima_field_data *field_data)
bcbc9b0cf Mimi Zohar      2013-07-23  161  {
bcbc9b0cf Mimi Zohar      2013-07-23  162  	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
bcbc9b0cf Mimi Zohar      2013-07-23  163  }
bcbc9b0cf Mimi Zohar      2013-07-23  164  
b17fd9ecf Roberto Sassu   2017-05-16  165  /**
b17fd9ecf Roberto Sassu   2017-05-16  166   * ima_parse_buf() - Parses lengths and data from an input buffer
b17fd9ecf Roberto Sassu   2017-05-16  167   * @bufstartp:       Buffer start address.
b17fd9ecf Roberto Sassu   2017-05-16  168   * @bufendp:         Buffer end address.
b17fd9ecf Roberto Sassu   2017-05-16  169   * @bufcurp:         Pointer to remaining (non-parsed) data.
b17fd9ecf Roberto Sassu   2017-05-16  170   * @maxfields:       Length of fields array.
b17fd9ecf Roberto Sassu   2017-05-16  171   * @fields:          Array containing lengths and pointers of parsed data.
b17fd9ecf Roberto Sassu   2017-05-16  172   * @curfields:       Number of array items containing parsed data.
b17fd9ecf Roberto Sassu   2017-05-16  173   * @len_mask:        Bitmap (if bit is set, data length should not be parsed).
b17fd9ecf Roberto Sassu   2017-05-16  174   * @enforce_mask:    Check if curfields == maxfields and/or bufcurp == bufendp.
b17fd9ecf Roberto Sassu   2017-05-16  175   * @bufname:         String identifier of the input buffer.
b17fd9ecf Roberto Sassu   2017-05-16  176   *
b17fd9ecf Roberto Sassu   2017-05-16  177   * Return: 0 on success, -EINVAL on error.
b17fd9ecf Roberto Sassu   2017-05-16  178   */
b17fd9ecf Roberto Sassu   2017-05-16  179  int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
b17fd9ecf Roberto Sassu   2017-05-16  180  		  int maxfields, struct ima_field_data *fields, int *curfields,
b17fd9ecf Roberto Sassu   2017-05-16  181  		  unsigned long *len_mask, int enforce_mask, char *bufname)
b17fd9ecf Roberto Sassu   2017-05-16  182  {
b17fd9ecf Roberto Sassu   2017-05-16  183  	void *bufp = bufstartp;
b17fd9ecf Roberto Sassu   2017-05-16  184  	int i;
b17fd9ecf Roberto Sassu   2017-05-16  185  
b17fd9ecf Roberto Sassu   2017-05-16  186  	for (i = 0; i < maxfields; i++) {
b17fd9ecf Roberto Sassu   2017-05-16  187  		if (len_mask == NULL || !test_bit(i, len_mask)) {
b17fd9ecf Roberto Sassu   2017-05-16  188  			if (bufp > (bufendp - sizeof(u32)))
b17fd9ecf Roberto Sassu   2017-05-16  189  				break;
b17fd9ecf Roberto Sassu   2017-05-16  190  
b17fd9ecf Roberto Sassu   2017-05-16  191  			fields[i].len = *(u32 *)bufp;
b17fd9ecf Roberto Sassu   2017-05-16  192  			if (ima_canonical_fmt)
b17fd9ecf Roberto Sassu   2017-05-16  193  				fields[i].len = le32_to_cpu(fields[i].len);
b17fd9ecf Roberto Sassu   2017-05-16  194  
b17fd9ecf Roberto Sassu   2017-05-16  195  			bufp += sizeof(u32);
b17fd9ecf Roberto Sassu   2017-05-16  196  		}
b17fd9ecf Roberto Sassu   2017-05-16  197  
b17fd9ecf Roberto Sassu   2017-05-16  198  		if (bufp > (bufendp - fields[i].len))
b17fd9ecf Roberto Sassu   2017-05-16  199  			break;
b17fd9ecf Roberto Sassu   2017-05-16  200  
b17fd9ecf Roberto Sassu   2017-05-16  201  		fields[i].data = bufp;
b17fd9ecf Roberto Sassu   2017-05-16  202  		bufp += fields[i].len;
b17fd9ecf Roberto Sassu   2017-05-16  203  	}
b17fd9ecf Roberto Sassu   2017-05-16  204  
b17fd9ecf Roberto Sassu   2017-05-16  205  	if ((enforce_mask & ENFORCE_FIELDS) && i != maxfields) {
b17fd9ecf Roberto Sassu   2017-05-16  206  		pr_err("%s: nr of fields mismatch: expected: %d, current: %d\n",
b17fd9ecf Roberto Sassu   2017-05-16  207  		       bufname, maxfields, i);
b17fd9ecf Roberto Sassu   2017-05-16  208  		return -EINVAL;
b17fd9ecf Roberto Sassu   2017-05-16  209  	}
b17fd9ecf Roberto Sassu   2017-05-16  210  
b17fd9ecf Roberto Sassu   2017-05-16  211  	if ((enforce_mask & ENFORCE_BUFEND) && bufp != bufendp) {
b17fd9ecf Roberto Sassu   2017-05-16  212  		pr_err("%s: buf end mismatch: expected: %p, current: %p\n",
b17fd9ecf Roberto Sassu   2017-05-16  213  		       bufname, bufendp, bufp);
b17fd9ecf Roberto Sassu   2017-05-16  214  		return -EINVAL;
b17fd9ecf Roberto Sassu   2017-05-16  215  	}
b17fd9ecf Roberto Sassu   2017-05-16  216  
b17fd9ecf Roberto Sassu   2017-05-16  217  	if (curfields)
b17fd9ecf Roberto Sassu   2017-05-16  218  		*curfields = i;
b17fd9ecf Roberto Sassu   2017-05-16  219  
b17fd9ecf Roberto Sassu   2017-05-16  220  	if (bufcurp)
b17fd9ecf Roberto Sassu   2017-05-16  221  		*bufcurp = bufp;
b17fd9ecf Roberto Sassu   2017-05-16  222  
b17fd9ecf Roberto Sassu   2017-05-16  223  	return 0;
b17fd9ecf Roberto Sassu   2017-05-16  224  }
b17fd9ecf Roberto Sassu   2017-05-16  225  
4d7aeee73 Roberto Sassu   2013-06-07  226  static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
b0b4536f1 Matthew Garrett 2019-05-17  227  				       struct ima_event_data *event_data,
b0b4536f1 Matthew Garrett 2019-05-17  228  				       struct ima_field_data *field_data,
b0b4536f1 Matthew Garrett 2019-05-17  229  				       bool from_vfs)
4d7aeee73 Roberto Sassu   2013-06-07  230  {
3ce1217d6 Roberto Sassu   2013-06-07  231  	/*
4d7aeee73 Roberto Sassu   2013-06-07  232  	 * digest formats:
4d7aeee73 Roberto Sassu   2013-06-07  233  	 *  - DATA_FMT_DIGEST: digest
4d7aeee73 Roberto Sassu   2013-06-07  234  	 *  - DATA_FMT_DIGEST_WITH_ALGO: [<hash algo>] + ':' + '\0' + digest,
4d7aeee73 Roberto Sassu   2013-06-07  235  	 *    where <hash algo> is provided if the hash algoritm is not
4d7aeee73 Roberto Sassu   2013-06-07  236  	 *    SHA1 or MD5
4d7aeee73 Roberto Sassu   2013-06-07  237  	 */
4d7aeee73 Roberto Sassu   2013-06-07  238  	u8 buffer[CRYPTO_MAX_ALG_NAME + 2 + IMA_MAX_DIGEST_SIZE] = { 0 };
4d7aeee73 Roberto Sassu   2013-06-07  239  	enum data_formats fmt = DATA_FMT_DIGEST;
4d7aeee73 Roberto Sassu   2013-06-07  240  	u32 offset = 0;
4d7aeee73 Roberto Sassu   2013-06-07  241  
b0b4536f1 Matthew Garrett 2019-05-17  242  	if (from_vfs)
b0b4536f1 Matthew Garrett 2019-05-17  243  		offset += snprintf(buffer, 5, "vfs:");
b0b4536f1 Matthew Garrett 2019-05-17  244  
dcf4e3928 Roberto Sassu   2013-11-08  245  	if (hash_algo < HASH_ALGO__LAST) {
4d7aeee73 Roberto Sassu   2013-06-07  246  		fmt = DATA_FMT_DIGEST_WITH_ALGO;
b0b4536f1 Matthew Garrett 2019-05-17  247  		offset += snprintf(buffer + offset, CRYPTO_MAX_ALG_NAME + 1,
b0b4536f1 Matthew Garrett 2019-05-17  248  				   "%s", hash_algo_name[hash_algo]);
4d7aeee73 Roberto Sassu   2013-06-07  249  		buffer[offset] = ':';
4d7aeee73 Roberto Sassu   2013-06-07  250  		offset += 2;
4d7aeee73 Roberto Sassu   2013-06-07  251  	}
4d7aeee73 Roberto Sassu   2013-06-07  252  
4d7aeee73 Roberto Sassu   2013-06-07  253  	if (digest)
4d7aeee73 Roberto Sassu   2013-06-07  254  		memcpy(buffer + offset, digest, digestsize);
4d7aeee73 Roberto Sassu   2013-06-07  255  	else
4d7aeee73 Roberto Sassu   2013-06-07  256  		/*
4d7aeee73 Roberto Sassu   2013-06-07  257  		 * If digest is NULL, the event being recorded is a violation.
4d7aeee73 Roberto Sassu   2013-06-07  258  		 * Make room for the digest by increasing the offset of
4d7aeee73 Roberto Sassu   2013-06-07  259  		 * IMA_DIGEST_SIZE.
4d7aeee73 Roberto Sassu   2013-06-07  260  		 */
4d7aeee73 Roberto Sassu   2013-06-07  261  		offset += IMA_DIGEST_SIZE;
4d7aeee73 Roberto Sassu   2013-06-07  262  
4d7aeee73 Roberto Sassu   2013-06-07  263  	return ima_write_template_field_data(buffer, offset + digestsize,
4d7aeee73 Roberto Sassu   2013-06-07  264  					     fmt, field_data);
4d7aeee73 Roberto Sassu   2013-06-07  265  }
4d7aeee73 Roberto Sassu   2013-06-07  266  
4d7aeee73 Roberto Sassu   2013-06-07  267  /*
4d7aeee73 Roberto Sassu   2013-06-07  268   * This function writes the digest of an event (with size limit).
3ce1217d6 Roberto Sassu   2013-06-07  269   */
23b574193 Roberto Sassu   2015-04-11  270  int ima_eventdigest_init(struct ima_event_data *event_data,
3ce1217d6 Roberto Sassu   2013-06-07  271  			 struct ima_field_data *field_data)
3ce1217d6 Roberto Sassu   2013-06-07  272  {
3ce1217d6 Roberto Sassu   2013-06-07  273  	struct {
3ce1217d6 Roberto Sassu   2013-06-07  274  		struct ima_digest_data hdr;
3ce1217d6 Roberto Sassu   2013-06-07  275  		char digest[IMA_MAX_DIGEST_SIZE];
3ce1217d6 Roberto Sassu   2013-06-07  276  	} hash;
4d7aeee73 Roberto Sassu   2013-06-07  277  	u8 *cur_digest = NULL;
4d7aeee73 Roberto Sassu   2013-06-07  278  	u32 cur_digestsize = 0;
3ce1217d6 Roberto Sassu   2013-06-07  279  	struct inode *inode;
3ce1217d6 Roberto Sassu   2013-06-07  280  	int result;
3ce1217d6 Roberto Sassu   2013-06-07  281  
3ce1217d6 Roberto Sassu   2013-06-07  282  	memset(&hash, 0, sizeof(hash));
3ce1217d6 Roberto Sassu   2013-06-07  283  
8d94eb9b5 Roberto Sassu   2015-04-11  284  	if (event_data->violation)	/* recording a violation. */
3ce1217d6 Roberto Sassu   2013-06-07  285  		goto out;
3ce1217d6 Roberto Sassu   2013-06-07  286  
23b574193 Roberto Sassu   2015-04-11  287  	if (ima_template_hash_algo_allowed(event_data->iint->ima_hash->algo)) {
23b574193 Roberto Sassu   2015-04-11  288  		cur_digest = event_data->iint->ima_hash->digest;
23b574193 Roberto Sassu   2015-04-11  289  		cur_digestsize = event_data->iint->ima_hash->length;
3ce1217d6 Roberto Sassu   2013-06-07  290  		goto out;
3ce1217d6 Roberto Sassu   2013-06-07  291  	}
3ce1217d6 Roberto Sassu   2013-06-07  292  
23b574193 Roberto Sassu   2015-04-11  293  	if (!event_data->file)	/* missing info to re-calculate the digest */
3ce1217d6 Roberto Sassu   2013-06-07  294  		return -EINVAL;
3ce1217d6 Roberto Sassu   2013-06-07  295  
23b574193 Roberto Sassu   2015-04-11  296  	inode = file_inode(event_data->file);
4d7aeee73 Roberto Sassu   2013-06-07  297  	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
4d7aeee73 Roberto Sassu   2013-06-07  298  	    ima_hash_algo : HASH_ALGO_SHA1;
16bcdb6da Matthew Garrett 2019-05-17 @299  	result = ima_calc_file_hash(event_data->file, &hash.hdr, false);
3ce1217d6 Roberto Sassu   2013-06-07  300  	if (result) {
3ce1217d6 Roberto Sassu   2013-06-07  301  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
23b574193 Roberto Sassu   2015-04-11  302  				    event_data->filename, "collect_data",
3ce1217d6 Roberto Sassu   2013-06-07  303  				    "failed", result, 0);
3ce1217d6 Roberto Sassu   2013-06-07  304  		return result;
3ce1217d6 Roberto Sassu   2013-06-07  305  	}
4d7aeee73 Roberto Sassu   2013-06-07  306  	cur_digest = hash.hdr.digest;
4d7aeee73 Roberto Sassu   2013-06-07  307  	cur_digestsize = hash.hdr.length;
3ce1217d6 Roberto Sassu   2013-06-07  308  out:
712a49bd7 Roberto Sassu   2013-11-08  309  	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
b0b4536f1 Matthew Garrett 2019-05-17  310  			       HASH_ALGO__LAST, event_data, field_data, false);
3ce1217d6 Roberto Sassu   2013-06-07  311  }
3ce1217d6 Roberto Sassu   2013-06-07  312  

:::::: The code at line 299 was first introduced by commit
:::::: 16bcdb6da2aa16a1457c8023e4b2efd9cfba5107 IMA: Optionally make use of filesystem-provided hashes

:::::: TO: Matthew Garrett <mjg59@google.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
